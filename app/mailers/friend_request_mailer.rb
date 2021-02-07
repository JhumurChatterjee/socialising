class FriendRequestMailer < ApplicationMailer
  def request_received(friend_request_id)
    friend_request = FriendRequest.find(friend_request_id)
    @friend = friend_request.friend
    @sender = friend_request.user
    mail to: @friend.email, subject: I18n.t("mailer.friend_request.received")
  end

  def request_accepted(friend_request_id)
    friend_request = FriendRequest.find(friend_request_id)
    @friend = friend_request.friend
    @sender = friend_request.user
    mail to: @sender.email, subject: I18n.t("mailer.friend_request.accepted")
  end
end
