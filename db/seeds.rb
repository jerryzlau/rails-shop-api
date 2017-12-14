# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# users
10.times do |n|
  User.create(first_name: Faker::Name.unique.first_name,
              last_name: Faker::Name.unique.last_name)
end 

# Categories 
Category.create(name: 'snacks')
Category.create(name: 'chips')
Category.create(name: 'crackers')

Category.create(name: 'breakfast')
Category.create(name: 'bars')
Category.create(name: 'cereal')

# order
Order.create(
  customer_id: 1
)

# food products 
# inventory (without order_id means not bought)
Product.create(name: 'Doritos Nacho Cheese Flavored Tortilla Chips, Party Size!',
  price: 4.77,
  weight: 15,
  category_id: 1,
  order_id: 1
)

Product.create(name: 'Doritos Nacho Cheese Flavored Tortilla Chips, Party Size!',
  price: 4.77,
  weight: 15,
  category_id: 2,
  order_id: 1)








