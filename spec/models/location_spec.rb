require "rails_helper"

RSpec.describe Location, type: :model do
  let(:location) { create(:location, address: "Kolkata") }

  describe "active record columns" do
    it { should have_db_column(:address) }
    it { should have_db_column(:latitude) }
    it { should have_db_column(:longitude) }
    it { should have_db_column(:user_id) }
    it { should have_db_column(:created_at) }
    it { should have_db_column(:updated_at) }
  end

  describe "active record index" do
    it { should have_db_index(:user_id) }
  end

  describe "validations" do
    it { should validate_presence_of(:address) }
  end

  describe "#associations" do
    it { should belong_to(:user) }
    it { should have_many(:shared_locations).dependent(:destroy) }
    it { should have_many(:users).through(:shared_locations) }
  end

  describe "scopes" do
    let(:user)                      { create :user }
    let(:friend)                    { create :user }
    let(:other_friend)              { create :user }
    let!(:publicly_shared_location) { create :location, user_id: other_friend.id, address: "Kolkata" }
    let!(:shared_location)          { create :shared_location, location_id: location.id, user_id: friend.id }

    context ".visible" do
      it "should show the location which was shared publicly to all users by specific user" do
        expect(Location.visible(other_friend.id)).to include(publicly_shared_location)
      end

      it "should not show the location which was not shared publicly to all users by specific user" do
        expect(Location.visible(user.id)).not_to include(location)
      end
    end

    context ".publicly_visible" do
      it "should show the location which was shared publicly to all users not by any specific user" do
        expect(Location.publicly_visible).to include(publicly_shared_location)
      end

      it "should not show the location which was not shared publicly to all users not by any specific user" do
        expect(Location.publicly_visible).not_to include(location)
      end
    end
  end

  describe "#check_valid_address" do
    context "when have given wrong address" do
      it "should add errors to error object" do
        loc = build(:location, address: "dcdvc")
        loc.save
        expect(loc.errors.count).to eq(1)
        expect(loc.errors.full_messages).to eq(["Please enter valid address"])
      end
    end

    context "when have given correct address" do
      it "should not add errors to error object" do
        loc = build(:location, address: "Kolkata")
        loc.save
        expect(loc.errors.count).to eq(0)
        expect(loc.errors.full_messages).to eq([])
      end
    end
  end
end
