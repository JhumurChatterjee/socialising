require "rails_helper"

describe FriendRequestsController, type: :controller do
  let(:user) { create(:user) }

  describe "#GET pending" do
    let(:friend_request) { create(:friend_request, friend: user) }

    it "requires login" do
      sign_out user
      get :pending
      expect(response).to redirect_to(new_user_session_url)
    end

    it "returns http status 200" do
      sign_in user
      get :pending
      expect(response).to have_http_status(:ok)
    end

    it "populates instance variable with an array of friend requests" do
      sign_in user
      get :pending
      expect(assigns(:friend_requests)).to eq([friend_request])
      expect(assigns(:friend_requests).size).to eq(1)
    end

    it "render pending template" do
      sign_in user
      get :pending
      expect(response).to render_template(:pending)
    end
  end

  describe "#GET accepted" do
    let(:friend_request) { create(:friend_request, friend: user, accepted_at: DateTime.now) }

    it "requires login" do
      sign_out user
      get :accepted
      expect(response).to redirect_to(new_user_session_url)
    end

    it "returns http status 200" do
      sign_in user
      get :accepted
      expect(response).to have_http_status(:ok)
    end

    it "populates instance variable with an array of friend requests" do
      sign_in user
      get :accepted
      expect(assigns(:friend_requests)).to eq([friend_request])
      expect(assigns(:friend_requests).size).to eq(1)
    end

    it "render accepted template" do
      sign_in user
      get :accepted
      expect(response).to render_template(:accepted)
    end
  end

  describe "#GET rejected" do
    let(:friend_request) { create(:friend_request, friend: user, rejected_at: DateTime.now) }

    it "requires login" do
      sign_out user
      get :rejected
      expect(response).to redirect_to(new_user_session_url)
    end

    it "returns http status 200" do
      sign_in user
      get :rejected
      expect(response).to have_http_status(:ok)
    end

    it "populates instance variable with an array of friend requests" do
      sign_in user
      get :rejected
      expect(assigns(:friend_requests)).to eq([friend_request])
      expect(assigns(:friend_requests).size).to eq(1)
    end

    it "render rejected template" do
      sign_in user
      get :rejected
      expect(response).to render_template(:rejected)
    end
  end

  describe "PATCH #update" do
    let(:friend_request) { create(:friend_request, friend: user, rejected_at: DateTime.now) }

    it "requires login" do
      sign_out user
      put :update, xhr: true, format: :js, params: { id: friend_request.id, type: "accept" }
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http status 200" do
      sign_in user
      put :update, xhr: true, format: :js, params: { id: friend_request.id, type: "accept" }
      expect(response).to have_http_status(:ok)
    end

    it "populates instance variable with a friend request object" do
      sign_in user
      put :update, xhr: true, format: :js, params: { id: friend_request.id, type: "accept" }
      expect(assigns(:friend_request)).to eq(friend_request)
    end

    it "updates the accepted_at field with the time of accepting the request" do
      sign_in user
      put :update, xhr: true, format: :js, params: { id: friend_request.id, type: "accept" }
      expect(friend_request.reload.accepted_at).not_to eq(nil)
    end
  end
end
