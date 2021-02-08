require "rails_helper"

describe UsersController, type: :controller do
  let(:user)            { create :user }
  let(:friend)          { create :user, username: "Jhumur" }
  let!(:friend_request) { create :friend_request, user: user, friend: friend }

  describe "#GET index" do
    let(:user) { create(:user) }

    it "requires login" do
      sign_out user
      get :index
      expect(response).to redirect_to(new_user_session_url)
    end

    it "returns http status 200" do
      sign_in user
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "populates instance variable with an array of users" do
      sign_in user
      get :index
      expect(assigns(:users).include?(friend)).to eq(true)
    end

    it "render index" do
      sign_in user
      get :index
      expect(response).to render_template(:index)
    end

    it "render index with search params" do
      sign_in user
      get :index, params: { search: "Jhumur" }
      expect(assigns(:users)).to eq([friend])
      expect(assigns(:users)).not_to eq([user])
      expect(response).to render_template(:index)
    end
  end

  describe "#GET show" do
    it "requires login" do
      sign_out user
      get :show, params: { id: "Jhumur" }
      expect(response).to redirect_to(new_user_session_url)
    end

    it "returns http status 200" do
      sign_in user
      get :show, params: { id: "Jhumur" }
      expect(response).to have_http_status(:ok)
    end

    it "populates instance variable with an object of user" do
      sign_in user
      get :show, params: { id: "Jhumur" }
      expect(assigns(:user)).to eq(friend)
    end

    it "render show" do
      sign_in user
      get :show, params: { id: "Jhumur" }
      expect(response).to render_template(:show)
    end

    it "render timeline page if no username matches" do
      sign_in user
      get :show, params: { id: "__" }
      expect(response).to redirect_to(timeline_path)
    end
  end
end
