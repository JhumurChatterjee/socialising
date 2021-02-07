class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :recoverable, :rememberable, :validatable, :confirmable, :lockable

  strip_attributes only: :username, collapse_spaces: true

  has_many :friend_requests,  dependent: :destroy
  has_many :locations,        dependent: :destroy
  has_many :shared_locations, dependent: :destroy

  validates :username, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  validates :email, presence: true, length: { maximum: 100 }

  scope :order_by_username, -> { order(username: :asc) }

  def self.search(query)
    query = query.to_s.strip

    if query.present?
      where("username ILIKE ?", "%#{query}%")
    else
      all
    end
  end
end
