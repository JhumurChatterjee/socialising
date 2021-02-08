require "rails_helper"

describe HomeController, type: :controller do
  describe "GET #index" do
    it "should return success status code" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "#GET timeline" do
    let(:user)                      { create :user }
    let!(:publicly_shared_location) { create :location, user_id: user.id, address: "Kolkata" }

    it "requires login" do
      sign_out user
      get :timeline
      expect(response).to redirect_to(new_user_session_url)
    end

    it "returns http status 200" do
      sign_in user
      get :timeline
      expect(response).to have_http_status(:ok)
    end

    it "populates instance variable with an array of users" do
      sign_in user
      get :timeline
      expect(assigns(:locations).include?(publicly_shared_location)).to eq(true)
      expect(assigns(:locations).size).to eq(1)
    end

    it "render index" do
      sign_in user
      get :timeline
      expect(response).to render_template(:timeline)
    end
  end
end
