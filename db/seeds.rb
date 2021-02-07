user = User.create(username: "Jhumur", email: "jhumurchatterjee1996@gmail.com", password: "123456", confirmed_at: DateTime.now)

25.times do |t|
  new_user = User.new(
    username: Faker::Internet.username + t.to_s,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 6, max_length: 128),
    confirmed_at: DateTime.now
  )

  next unless new_user.save

  if Faker::Boolean.boolean
    FriendRequest.create(user: new_user, friend: user, accepted_at: DateTime.now)
    new_user.update(mutual_friend_ids: new_user.mutual_friend_ids.push(user.id))
    user.update(mutual_friend_ids: user.mutual_friend_ids.push(new_user.id))
    location = Location.create(user: user, address: Faker::Address.street_address)
    SharedLocation.create(location_id: location.id, user_id: new_user.id) if location
    location = Location.create(user: new_user, address: Faker::Address.street_address)
    SharedLocation.create(location_id: location.id, user_id: user.id) if location
  else
    FriendRequest.create(user: new_user, friend: user)
    Location.create(user: user, address: Faker::Address.street_address)
  end
end
