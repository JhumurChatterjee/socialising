FactoryBot.define do
  factory :friend_request do
    user
    friend { create :user }
  end
end
