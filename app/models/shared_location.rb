class SharedLocation < ApplicationRecord
  belongs_to :user
  belongs_to :location
end
