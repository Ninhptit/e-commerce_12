User.create! name: "hai ha", email: "haiha210.gm@gmail.com", password: "123456",
  password_confirmation: "123456", role: 2, address: FFaker::Address.street_address + ", " + FFaker::Address.city, 
  verified: true, activated_at: Time.zone.now,phone: FFaker::PhoneNumber.phone_number, remote_avatar_url: FFaker::Avatar.image,
  birthday: FFaker::Time.between(50.year.ago, 20.year.ago)

User.create! name: "hai ha", email: "haiha21.gm@gmail.com", password: "123456",
  password_confirmation: "123456", role: 1,
  address: FFaker::Address.street_address + ", " + FFaker::Address.city, 
  verified: true, activated_at: Time.zone.now, remote_avatar_url: FFaker::Avatar.image(slug = nil, size = '300x300', format = 'png', bgset = nil),
  birthday: FFaker::Time.between(50.year.ago, 20.year.ago)


10.times do |n|
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
categories = Category.order(:created_at).take(5)

20.times do
  categories.each { |category| users[1].products.create! name: FFaker::Name.name, 
    price: (100 * FFaker::Random.rand).round(2), descriptions: FFaker::Lorem.paragraph,
    category_id: category.id
  }
end

Product.all.each { |product| product.type_products.create! color: FFaker::Color.name, size: FFaker::Random.rand(35..42), quantity: FFaker::Random.rand(10..20)}
TypeProduct.all.each { |product| product.images.create! remote_image_url_url: FFaker::Avatar.image(slug = nil, size = '250x250', format = 'png', bgset = nil)}

10.times do |n|
  start_date = FFaker::Time.between(2.days.ago , Date.today + 2.weeks)
  end_date = start_date + 2.days
  description = FFaker::Lorem.paragraph
  Promotion.create! start_date: start_date, end_date: end_date, description: description
end

Product.all.each { |product| product.product_promotions.create! promotion_id: FFaker::Random.rand(1..10), percent: FFaker::Random.rand(5..15) }

users.each { |user| user.orders.create! address: FFaker::Address.street_address + ", " + FFaker::Address.city,
                                       phone: FFaker::PhoneNumber.phone_number,
                                       status: true}
Order.all.each { |order| order.order_details.create! type_product_id: FFaker::Random.rand(1..100),
                                                     quantity: FFaker::Random.rand(1..10)}                                       

