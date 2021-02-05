class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def pending
    @friend_requests = FriendRequest.received(current_user).pending.includes(:user)
  end

  def accepted
    @friend_requests = FriendRequest.received(current_user).accepted.includes(:user)
  end

  def rejected
    @friend_requests = FriendRequest.received(current_user).rejected.includes(:user)
  end
end
