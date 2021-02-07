require "rails_helper"

describe LocationsController, type: :controller do
  let(:user)      { create :user }
  let(:location) { create :location, user_id: user.id }

  describe "GET #new" do
    it "requires login" do
      sign_out user
      get :new, xhr: true, format: :js
      expect(response).to have_http_status(:unauthorized)
    end

    it "returns http status 200" do
      sign_in user
      get :new, xhr: true, format: :js
      expect(response).to have_http_status(:ok)
    end

    it "assigns a new location to an instance variable" do
      sign_in user
      get :new, xhr: true, format: :js
      expect(assigns(:location)).to be_a_new(Location)
    end

    it "render new template" do
      sign_in user
      get :new, xhr: true, format: :js
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let(:friend) { create :user }

    it "requires login" do
      sign_out user
      post :create, xhr: true, format: :js, params: { location: { address: "Kolkata", user_ids: [friend.id] }}
      expect(response).to have_http_status(:unauthorized)
    end

    context "with valid attributes" do
      it "saves the new location in the database" do
        sign_in user
        expect {
          post :create, xhr: true, format: :js, params: { location: { address: "Kolkata", user_ids: [friend.id] }}
        }.to change(Location, :count).by(1)
      end

      it "returns http status 200" do
        sign_in user
        post :create, xhr: true, format: :js, params: { location: { address: "Kolkata", user_ids: [friend.id] }}
        expect(response).to have_http_status(200)
      end

      it "assigns a newly created but unsaved location to an instance variable" do
        sign_in user
        post :create, xhr: true, format: :js, params: { location: { address: "Kolkata", user_ids: [friend.id] }}
        expect(assigns(:location)).to be_a(Location)
        expect(assigns(:location)).to be_persisted
      end

      it "have success flash message" do
        sign_in user
        post :create, xhr: true, format: :js, params: { location: { address: "Kolkata", user_ids: [friend.id] }}
        expect(flash[:success]).to eq(I18n.t("share_success"))
      end

      it "redirects to accepted request index page" do
        sign_in user
        post :create, xhr: true, format: :js, params: { location: { address: "Kolkata", user_ids: [friend.id] }}
        expect(response).to redirect_to(timeline_path)
      end
    end

    context "with invalid attributes" do
      it "does not save the new location in the database" do
        sign_in user
        expect{
          post :create, xhr: true, format: :js, params: { location: { address: nil, user_ids: [friend.id] }}
        }.not_to change(Location, :count)
      end

      it "assigns a newly created but unsaved location instance variable" do
        sign_in user
        post :create, xhr: true, format: :js, params: { location: { address: nil, user_ids: [friend.id] }}
        expect(assigns(:location)).to be_a_new(Location)
      end

      it "returns http status 200" do
        sign_in user
        post :create, xhr: true, format: :js, params: { location: { address: nil, user_ids: [friend.id] }}
        expect(response).to have_http_status(:ok)
      end

      it "re-renders the :new template" do
        sign_in user
        post :create, xhr: true, format: :js, params: { location: { address: "" }}
        expect(response).to render_template(:new)
      end
    end
  end
end
