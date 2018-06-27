User.create! name: "hai ha", email: "haiha210.gm@gmail.com", password: "123456",
  password_confirmation: "123456", role: 2, address: FFaker::Address.street_address + ", " + FFaker::Address.city, 
  verified: true, activated_at: Time.zone.now,phone: FFaker::PhoneNumber.phone_number, remote_avatar_url: FFaker::Avatar.image,
  birthday: FFaker::Time.between(50.year.ago, 20.year.ago)

User.create! name: "hai ha", email: "haiha21.gm@gmail.com", password: "123456",
  password_confirmation: "123456", role: 1,
  address: FFaker::Address.street_address + ", " + FFaker::Address.city, 
  verified: true, activated_at: Time.zone.now, remote_avatar_url: FFaker::Avatar.image(slug = nil, size = '300x300', format = 'png', bgset = nil),
  birthday: FFaker::Time.between(50.year.ago, 20.year.ago)

99.times do |n|
  name = FFaker::Name.name
  email = FFaker::Internet.email
  address = FFaker::Address.street_address + ", " + FFaker::Address.city
  avatar = FFaker::Avatar.image(slug = nil, size = '300x300', format = 'png', bgset = nil)
  password = "123456"
  phone = FFaker::PhoneNumber.phone_number
  birthday = FFaker::Time.between 50.year.ago, 20.year.ago
  User.create! name: name, email: email, password: password, password_confirmation: password,
    verified: true, activated_at: Time.zone.now, address: address, phone: phone, birthday: birthday,
    remote_avatar_url: avatar
end

users = User.order(:created_at).take(6)
30.times do
  users.each { |user| user.categories.create! name: FFaker::Name.name }
end
categories = Category.order(:created_at).take(10)

50.times do
  categories.each { |category| users[1].products.create! name: FFaker::Name.name, 
    price: (100 * FFaker::Random.rand).round(2), descriptions: FFaker::Lorem.paragraph,
    category_id: category.id
  }
end

Product.all.each { |product| product.images.create! remote_image_url_url: FFaker::Avatar.image(slug = nil, size = '250x250', format = 'png', bgset = nil)}
