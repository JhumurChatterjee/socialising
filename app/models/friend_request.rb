class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  scope :received, ->(user) { where(friend_id: user.id) }
  scope :pending,  -> { where(accepted_at: nil, rejected_at: nil) }
  scope :accepted, -> { where.not(accepted_at: nil).where(rejected_at: nil) }
  scope :rejected, -> { where.not(rejected_at: nil).where(accepted_at: nil) }

  def update_request(type)
    if type == "accept"
      update(accepted_at: Time.current)
      friend.update(mutual_friend_ids: friend.mutual_friend_ids.push(user_id))
      user.update(mutual_friend_ids: user.mutual_friend_ids.push(friend_id))
    elsif type == "reject"
      update(rejected_at: Time.current)
    end
  end
end
