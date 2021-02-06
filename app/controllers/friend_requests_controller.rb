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

  def create
    @friend_request = FriendRequest.create(friend_request_params)
  end

  def update
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.update_request(params[:type])
  end

  private

  def friend_request_params
    params.require(:friend_request).permit(:friend_id).merge(user: current_user)
  end
end
