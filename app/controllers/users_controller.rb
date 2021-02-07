class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.search(params[:search]).order_by_username
    @pending_user_ids = FriendRequest.received(current_user).pending.pluck(:user_id)
    @sent_user_ids = current_user.friend_requests.pending.pluck(:friend_id)
  end

  def show
    @user = User.find_by(username: params[:id])
    redirect_to timeline_path unless @user

    @pagy, @locations = pagy_countless(@user.locations.publicly_visible, items: 21, link_extra: 'data-remote="true"')
  end
end
