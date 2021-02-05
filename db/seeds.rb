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
  else
    FriendRequest.create(user: new_user, friend: user)
  end
end
