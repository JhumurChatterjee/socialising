require "rails_helper"

RSpec.describe FriendRequestMailer, type: :mailer do
  let(:user)           { create :user }
  let(:friend)         { create :user }
  let(:friend_request) { create(:friend_request, user_id: user.id, friend_id: friend.id ) }

  describe "#request_received" do
    let(:mail) { FriendRequestMailer.request_received(friend_request.id) }

    it "renders the headers" do
      expect(mail.subject).to eq(I18n.t("mailer.friend_request.received"))
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([friend.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['jhumurchatterjee1996@gmail.com'])
    end

    it 'assigns @sender' do
      expect(mail.body.encoded).to match(user.username)
    end

    it 'assigns @friend' do
      expect(mail.body.encoded).to match(friend.username)
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("#{user.username} wants to be friends with you!!")
    end
  end

  describe "#request_accepted" do
    let(:mail) { FriendRequestMailer.request_accepted(friend_request.id) }

    it "renders the headers" do
      expect(mail.subject).to eq(I18n.t("mailer.friend_request.accepted"))
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['jhumurchatterjee1996@gmail.com'])
    end

    it 'assigns @sender' do
      expect(mail.body.encoded).to match(user.username)
    end

    it 'assigns @friend' do
      expect(mail.body.encoded).to match(friend.username)
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("#{friend.username} has accepted your request.")
    end
  end
end
