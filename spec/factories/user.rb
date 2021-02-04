FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email    { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6, max_length: 128) }
  end
end
