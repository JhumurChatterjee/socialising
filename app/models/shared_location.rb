class SharedLocation < ApplicationRecord
  after_create :send_notification

  belongs_to :user
  belongs_to :location

  private

  def send_notification
    LocationSharingMailer.location_shared(id).deliver_now
  end
end
