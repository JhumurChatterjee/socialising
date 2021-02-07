class Location < ApplicationRecord
  geocoded_by :address

  after_validation :geocode
  before_save :check_valid_address

  belongs_to :user

  has_many :shared_locations, dependent: :destroy
  has_many :users, through: :shared_locations

  validates :address, presence: true

  scope :visible, ->(user_id) { left_outer_joins(:shared_locations).where("locations.user_id = :user_id OR shared_locations.user_id = :user_id", user_id: user_id).distinct }
  scope :publicly_visible, -> { left_outer_joins(:shared_locations).where(shared_locations: { id: nil }) }

  private

  def check_valid_address
    if !latitude && !longitude
      errors.add(:base, "Please enter valid address")
      throw :abort
    end
  end
end
