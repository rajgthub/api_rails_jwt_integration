require 'rails_helper'

RSpec.describe "V1::Sessions", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/v1/sessions/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/v1/sessions/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
