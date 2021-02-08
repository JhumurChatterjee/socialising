require "rails_helper"

RSpec.describe SharedLocation, type: :model do
  let(:user) { create :user }

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

  describe "#send_notification" do
    let(:friend)   { create :user }
    let(:location) { create :location, user_id: user.id, address: "Kolkata" }

    context "when we want to send notification to recipient" do
      it "sends an email" do
        expect {
          SharedLocation.new(location_id: location.id, user_id: user.id).save
        }.to change { ActionMailer::Base.deliveries.count }.by(2)

        ActionMailer::Base.deliveries.last.tap do |mail|
          expect(mail.from).to eq(["jhumurchatterjee1996@gmail.com"])
          expect(mail.subject).to eq(I18n.t("mailer.location.shared"))
        end
      end
    end
  end
end
