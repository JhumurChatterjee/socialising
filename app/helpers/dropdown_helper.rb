module DropdownHelper
  def friend_list_dropdown
    User.where(id: current_user.mutual_friend_ids).pluck(:username, :id)
  end
end
