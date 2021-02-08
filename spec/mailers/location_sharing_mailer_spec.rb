require "rails_helper"

RSpec.describe LocationSharingMailer, type: :mailer do
  let(:user)            { create :user }
  let(:friend)          { create :user }
  let(:location)        { create :location, user_id: user.id, address: "Kolkata" }
  let(:shared_location) { create(:shared_location, location_id: location.id, user_id: friend.id) }

  describe "#location_shared" do
    let(:mail) { LocationSharingMailer.location_shared(shared_location.id) }

    it "renders the headers" do
      expect(mail.subject).to eq(I18n.t("mailer.location.shared"))
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([friend.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['jhumurchatterjee1996@gmail.com'])
    end

    it 'assigns @recipient' do
      expect(mail.body.encoded).to match(friend.username)
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("#{friend.username} has shared location with you.")
    end
  end
end
