require "rails_helper"

RSpec.describe Location, type: :model do
  let(:location) { create(:location) }

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
end
