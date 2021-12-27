class V1::SessionsController < ApplicationController
  def create
    @user = User.where(email: params[:email]).first
    if @user&.valid_password?(params[:password])
      # render :create, status: :created
      payload = {user_id: @user.id, exp: (Time.now + 2.weeks).to_i}
      jwt_token = JWT.encode(payload,
        Rails.application.secrets.secret_key_base,
        'HS256'
      )
      render :create, locals: {jwt_token: jwt_token}, status: :created
    else
      head :unauthorized
    end
  end

  def destroy
  end
end
