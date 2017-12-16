# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# users
3.times do |n|
  User.create(first_name: Faker::Name.unique.first_name,
              last_name: Faker::Name.unique.last_name)
end 

# Order
Order.create(
  customer_id: 1
)

Order.create(
  customer_id: 2
)

Order.create(
  customer_id: 1
)

# Category
Category.create(name: 'snacks')
Category.create(name: 'chips')
Category.create(name: 'crackers')

# Product weight in oz
# Product 1
Product.create(name: 'Doritos Nacho Cheese Flavored Tortilla Chips, Party Size!',
  price: 4.77,
  weight: 15,
  inventory: 1
) 

# Product 2
Product.create(name: 'Entertainment Cracker Collection,43.31 OZ',
  price: 16.57,
  weight: 43.31,
  inventory: 20
) 

# Product 3
Product.create(name: 'Pringles 2 Flavor Snack Stacks, 0.63 Ounce, 18 count',
  price: 12.50,
  weight: 0.63,
  inventory: 20
)

# Product Category 
# Doritos Nacho Cheese Flavored Tortilla Chips, Party Size!
ProductCategory.create(
  category_id: 1,
  product_id: 1
)
ProductCategory.create(
  category_id: 2,
  product_id: 1
)

# Entertainment Cracker Collection,43.31 OZ
ProductCategory.create(
  category_id: 1,
  product_id: 2
)
ProductCategory.create(
  category_id: 3,
  product_id: 2
)

# Pringles 2 Flavor Snack Stacks, 0.63 Ounce, 18 count
ProductCategory.create(
  category_id: 1,
  product_id: 3
)
ProductCategory.create(
  category_id: 2,
  product_id: 3
)

# Order Items
# Order 1
OrderItem.create(
  order_id: 1,
  product_id: 1,
)
OrderItem.create(
  order_id: 1,
  product_id: 1,
)
OrderItem.create(
  order_id: 1,
  product_id: 2,
)

# Order 2
OrderItem.create(
  order_id: 2,
  product_id: 3,
)

# Order 3
OrderItem.create(
  order_id: 3,
  product_id: 3,
)
OrderItem.create(
  order_id: 3,
  product_id: 2,
)









