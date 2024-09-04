require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/game/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/game/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/game/index"
      expect(response).to have_http_status(:success)
    end
  end

end
