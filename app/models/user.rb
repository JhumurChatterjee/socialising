class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :recoverable, :rememberable, :validatable, :confirmable, :lockable

  strip_attributes only: :username, collapse_spaces: true

  validates :username, presence: true, length: { maximum: 20 }, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  validates :email, presence: true, length: { maximum: 100 }
end
