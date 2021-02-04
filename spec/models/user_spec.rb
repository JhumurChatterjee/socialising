require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "active record columns" do
    it { should have_db_column(:username) }
    it { should have_db_column(:email) }
    it { should have_db_column(:encrypted_password) }
    it { should have_db_column(:reset_password_token) }
    it { should have_db_column(:reset_password_sent_at) }
    it { should have_db_column(:remember_created_at) }
    it { should have_db_column(:sign_in_count) }
    it { should have_db_column(:current_sign_in_at) }
    it { should have_db_column(:last_sign_in_at) }
    it { should have_db_column(:current_sign_in_ip) }
    it { should have_db_column(:last_sign_in_ip) }
    it { should have_db_column(:confirmation_token) }
    it { should have_db_column(:confirmed_at) }
    it { should have_db_column(:confirmation_sent_at) }
    it { should have_db_column(:unconfirmed_email) }
    it { should have_db_column(:failed_attempts) }
    it { should have_db_column(:unlock_token) }
    it { should have_db_column(:locked_at) }
    it { should have_db_column(:created_at) }
    it { should have_db_column(:updated_at) }
  end

  describe "active record index" do
    it { should have_db_index(:confirmation_token) }
    it { should have_db_index(:email) }
    it { should have_db_index(:username) }
    it { should have_db_index(:reset_password_token) }
    it { should have_db_index(:unlock_token) }
  end

  describe "attribute strip" do
    it { is_expected.to strip_attribute(:username).collapse_spaces }
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:username).is_at_most(20) }
    it { should validate_length_of(:email).is_at_most(100) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should allow_value('jhumur').for(:username) }
  end
end
