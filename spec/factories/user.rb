FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 'Nancy') + ((Time.now + rand(10..999).days).to_f * rand(10..99999)).to_i.to_s }
    email    { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6, max_length: 128) }
  end
end
