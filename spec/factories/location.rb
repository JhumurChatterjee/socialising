FactoryBot.define do
  factory :location do
    address { Faker::Address.street_address }
    user
  end
end
