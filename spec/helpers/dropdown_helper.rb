require "rails_helper"

RSpec.describe DropdownHelper, type: :helper do
  let(:friend)       { create :user }
  let(:user)         { create :user, mutual_friend_ids: [friend.id] }
  let(:current_user) { user }

  describe "#friend_list_dropdown" do
    context "when we want to have a list of users who are friends to current_user" do
      it "should return list of users friends to current_user" do
        expect(friend_list_dropdown).to include([friend.username, friend.id])
      end
    end
  end
end
