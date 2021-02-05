require "rails_helper"

RSpec.describe FriendRequest, type: :model do
  let(:friend_request) { create(:friend_request) }

  describe "active record columns" do
    it { should have_db_column(:user_id) }
    it { should have_db_column(:friend_id) }
    it { should have_db_column(:accepted_at) }
    it { should have_db_column(:rejected_at) }
    it { should have_db_column(:created_at) }
    it { should have_db_column(:updated_at) }
  end

  describe "active record index" do
    it { should have_db_index(:friend_id) }
    it { should have_db_index(:user_id) }
  end

  describe "#associations" do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name("User") }
  end

  describe "#scopes" do
    let!(:user_1) { create(:user) }
    let!(:user_2) { create(:user) }
    let!(:user_3) { create(:user) }
    let!(:friend_request_1) { create(:friend_request, user: user_1, friend: user_2, accepted_at: DateTime.now) }
    let!(:friend_request_2) { create(:friend_request, user: user_1, friend: user_3) }
    let!(:friend_request_3) { create(:friend_request, user: user_1, friend: user_3, rejected_at: DateTime.now) }

    context "received" do
      it "should return requests of a user" do
        expect(FriendRequest.received(user_2).include?(friend_request_1)).to eq(true)
        expect(FriendRequest.received(user_2).include?(friend_request_2)).to eq(false)
      end
    end

    context "pending" do
      it "should return pending requests of a user" do
        expect(FriendRequest.pending.include?(friend_request_2)).to eq(true)
        expect(FriendRequest.pending.include?(friend_request_1)).to eq(false)
      end
    end

    context "accepted" do
      it "should return accepted requests of a user" do
        expect(FriendRequest.accepted.include?(friend_request_1)).to eq(true)
        expect(FriendRequest.accepted.include?(friend_request_2)).to eq(false)
      end
    end

    context "rejected" do
      it "should return rejected requests of a user" do
        expect(FriendRequest.rejected.include?(friend_request_3)).to eq(true)
        expect(FriendRequest.rejected.include?(friend_request_2)).to eq(false)
      end
    end
  end

  describe "update_request" do
    context "when we want to add time of accepting request to accepted_at field" do
      before { friend_request.update_request("accept") }

      it "should add time of accepting request to accepted_at field" do
        expect(friend_request.accepted_at).not_to eq(nil)
      end

      it "should not add time of accepting request to rejected_at field" do
        expect(friend_request.rejected_at).to eq(nil)
      end
    end

    context "when we want to add time of rejecting request to rejected_at field" do
      before { friend_request.update_request("reject") }

      it "should add time of rejecting request to rejected_at field" do
        expect(friend_request.rejected_at).not_to eq(nil)
      end

      it "should not add time of accepting request to accepted_at field" do
        expect(friend_request.accepted_at).to eq(nil)
      end
    end
  end
end
