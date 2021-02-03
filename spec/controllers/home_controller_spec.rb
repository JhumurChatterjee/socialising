require "rails_helper"

describe HomeController, type: :controller do
  describe "GET #index" do
    it "should return success status code" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
