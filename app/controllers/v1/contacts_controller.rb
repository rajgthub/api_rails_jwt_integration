class V1::ContactsController < ApplicationController
  include ActionController::HttpAuthentication::Token
  before_action :authenticate_user, except: :index
  def index
    @contacts = Contact.all
    render json: @contacts, status: :ok
  end

  def create
    @contact = Contact.new contact_params
    if @contact.save
      render json: @contact, status: :created
    else 
      head(:bad_request)
    end
  end

  def delete
    @contact = Contact.where(id: params[:id]).first
    if @contact.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def show
    @contact = Contact.find(params[:id])
    render json: @contact, status: :ok
  end

  private
    def contact_params 
      params.require(:contact).permit(:first_name, :last_name, :email)
    end
    def authenticate_user
      jwt_token, _options = token_and_options(request)
      payload, algorithm = JWT.decode( jwt_token,
        Rails.application.secrets.secret_key_base, true,
          {algorithm: "HS256"}
        ) 
      User.find(payload["user_id"])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      head :unauthorized
    end
end
