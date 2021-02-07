require "rails_helper"

RSpec.describe SharedLocation, type: :model do
  let(:shared_location) { create(:shared_location) }

  describe "active record columns" do
    it { should have_db_column(:location_id) }
    it { should have_db_column(:user_id) }
    it { should have_db_column(:created_at) }
    it { should have_db_column(:updated_at) }
  end

  describe "active record index" do
    it { should have_db_index(:user_id) }
    it { should have_db_index(:location_id) }
  end

  describe "#associations" do
    it { should belong_to(:user) }
    it { should belong_to(:location) }
  end
end
