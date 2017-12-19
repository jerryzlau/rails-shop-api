# Questions

## Design 

Please view [README](https://github.com/jerryzlau/rails-shop-api/blob/master/README.md) for schema detail

### Product 

1. Product table acts as inventory and product index.
2. I created a join table product_categories to categorize each product, this way a product and category can retain a many_to_many relationship
3. I created a join table order_items so that orders and product can have a many_to_many relationship. My [order.create](https://github.com/jerryzlau/rails-shop-api/blob/master/app/controllers/orders_controller.rb) function also checks inventory before executing an order.

## Tasks

1. A product belongs to many categories. A category has many products. A product can be sold in decimal amounts (such as weights).

* Visit `localhost:3000/products` to view product index and inventory

```ruby 
  # Product price and weight are stored as decimal in database 
  t.decimal "price", precision: 10, scale: 2, null: false
  t.decimal "weight", precision: 10, scale: 2, null: false
```

2. A customer can have many orders. An order is comprised of many products. An order has a status stating if the order is waiting for delivery, on its way, or delivered.

* Visit `localhost:3000/orders` to view all orders 

```ruby 
  # leveraged active record assocations and join table to get all order's items. ex: Order.first.products in rails c
  has_many :ordered_items,
  primary_key: :id,
  foreign_key: :order_id,
  class_name: :OrderItem

  has_many :products,
  through: :ordered_items,
  source: :product
```

3. Write a SQL query to return the results as display below:

* Leveraged active record to acquire requested result. Visit `localhost:3000/orders/shipt_search/:order_id` to view result of the search result 

| customer id   | customer first name | category id | category name | number purchased |
| ------------  | ------------------- | --------    |  ----------   | ---------------- |
| 1             |         John        |      1      | Bouquets      |        15        |n	1	Bouquets	15

4. An API end point that accepts a date range and a day, week, or month and returns a breakdown of products sold by quantity per day/week/month.

* Use postman with params at `POST localhost:3000/orderitems/search_by_date_range` to view query result

```json
  // example params
  {
	"start_date": "2017-12-16",
	"end_date": "2017-12-16",
	"range": "week"
  }
```

```ruby 
  def self.find_by_date(start_date, end_date, range)
    OrderItem.where("DATE(created_at) BETWEEN ? AND ?","%#{start_date}%", "%#{end_date}%")
      .group("DATE(DATE_TRUNC('#{range}', created_at))").count
  end 
```

5. Ability to export the results of #4 to CSV.

* Use postman with params at `POST localhost:3000/orderitems/search_by_date_range.csv` to export search result as csv

7. An API end point that returns the orders for a customer.

* Visit `localhost:3000/users/:user_id` to view user's orders

## Additional Questions

1. We want to give customers the ability to create lists of products for one-click ordering of bulk items. How would you design the tables, what are the pros and cons of your approach?

### Approach 

* Out of curiosity, I have built the basic table structure and controller create method to answer this question. Please view [Order Controller](https://github.com/jerryzlau/rails-shop-api/blob/master/app/controllers/orders_controller.rb) to review code 
* I have set up a join table for products and orders called order_items. 
* Order.create will receive `customer_id` and an array of `product_id` as parameter. The method first check if there is enough inventory for the order, if yes, then create an entry in `order_items` for each given `product_id` with the same `customer_id`. 
* Since we have already check if there are enough inventory, after entires are created in `order_items`, the corresponding product's inventory count will be decremented by the num of that product in the order.
* You can try out this method in postman at `POST localhost:3000/orders` with params:
```json 
  // params for orders create with sample data
  "customer_id": 1,
  "order_items": [1,2,2,3,3,3,4] 
```

### pros 
  Having a join table `order_items` helps to avoid making multiple product entry to keep inventory count. Product table can serve as both and index of product and inventory count. Otherwise, if Product table will have to delete a product entry entirely if there is no inventory. 

### cons
  There are quite a few operations to make sure that every table's data is insync with each other. If part of the Order.create failed, we would be creating inconsistent data across the tables. However, there is a way to solve this problem. I could use transactions to make sure that all operations are performed, if anything goes wrong, a transaction will rollback all operations so that there won't be inconsistent data across tables.

2. If Shipt knew exact inventory of stores, and when facing a high traffic and limited supply of particular item, how do you distribute the inventory among customers checking out?

  Just like how we would in a physical shopping experience. I would create a queue of order inqueries and process them in order. If inventory is out, then it would still be first come first serve. In order to make sure all customers are satisfied, I would also set a cap on how many of a certain product can be bought, so that no customer can out stock a product.