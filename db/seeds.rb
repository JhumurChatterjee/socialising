user = User.create(username: "Jhumur", email: "jhumurchatterjee1996@gmail.com", password: "123456", confirmed_at: DateTime.now) if Rails.env.development?

50.times do |t|
  User.create(
    username: Faker::Internet.username + t.to_s,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 6, max_length: 128),
    confirmed_at: DateTime.now
  )
end

user = User.first
pending_users = User.order("RANDOM()").reject { |u| u == user }.first(10)

pending_users.each do |pu|
  FriendRequest.create(user: pu, friend: user)
end

accepted_users = User.where.not(id: pending_users.map(&:id)).order("RANDOM()").reject { |u| u == user }.first(10)

pending_users.each do |au|
  FriendRequest.create(user: au, friend: user, accepted_at: DateTime.now)
  au.update(mutual_friend_ids: au.mutual_friend_ids.push(user.id))
  user.update(mutual_friend_ids: user.mutual_friend_ids.push(au.id))
end

rejected_users = User.where.not(id: pending_users.map(&:id) + accepted_users.map(&:id)).order("RANDOM()").reject { |u| u == user }.first(10)

rejected_users.each do |ru|
  FriendRequest.create(user: ru, friend: user, rejected_at: DateTime.now)
end

20.times do
  location = Location.create(user: user, address: Faker::Address.street_address)
  next unless location.id

  next unless Faker::Boolean.boolean

  array = 7.times.map { user.mutual_friend_ids.sample }.uniq

  array.each do |id|
    SharedLocation.create(location: location, user_id: id)
  end
end

10.times do
  Location.create(user: user, address: Faker::Address.street_address)
end

array = 10.times.map { user.mutual_friend_ids.sample }.uniq
users = User.where(id: array)

users.each do |u|
  10.times do
    location = Location.create(user: u, address: Faker::Address.street_address)
    next unless location.id

    SharedLocation.create(location: location, user_id: user.id)
  end
end
