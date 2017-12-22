# Shopping API

[Shipt Question Guide](/Shipt_questions.md)

## Design

1. Product table acts as inventory and product index.
2. I created a join table product_categories to categorize each product, this way a product and category can retain a many_to_many relationship
3. I created a join table order_items so that orders and product can have a many_to_many relationship. My [order.create](/app/controllers/orders_controller.rb) function also checks inventory before executing an order.

## Schema

### User 

| Column Name   | Data Type     | Details |
| ------------- |:-------------:| -----:  |
| id            | integer       | not null, primary key |
| first_name    | string        | not null |
| last_name     | string        | not null |

### Product 

| Column Name   | Data Type     | Details |
| ------------- |:-------------:| -----:  |
| id            | integer       | not null, primary key |
| name          | string        | not null |
| price         | decimal       | not null |
| weight        | decimal       | not null |
| inventory     | integer       | not null |
| category_id   | integer       | not null |

### Category

| Column Name   | Data Type     | Details |
| ------------- |:-------------:| -----:  |
| id            | integer       | not null, primary key |
| name          | string        | not null |

### Product_Category

| Column Name   | Data Type     | Details |
| ------------- |:-------------:| -----:  |
| id            | integer       | not null, primary key |
| category_id   | string        | not null |
| product_id    | string        | not null |

### Order

| Column Name   | Data Type     | Details |
| ------------- |:-------------:| -----:|
| id            | integer       | not null, primary key |
| status        | string        | default: 'waiting for delivery' |
| customer_id   | integer       | not null |

### Order Items

| Column Name   | Data Type     | Details |
| ------------- |:-------------:| -----:|
| id            | integer       | not null, primary key |
| order_id      | string        | default: 'waiting for delivery' |
| product_id    | integer       | not null |

## Routes - comments are added to explain how custom routes work in controller

### Users

* `GET /users/:id` - return a user info and orders associated with the user
* `POST /users` - sign up a user with first and last name 
* `DELETE /users/:id` - delete a user account 

### Products

* `GET /products` - return all products and their inventory 
* `GET /products/:id` - return a specific product's detail
* `POST /products` - create a product 
* `DELETE /products/:id` - delete a product 
* `PATCH /products/:id` - update a product 
* `POST /products/add_categories/:id` - add categories to product by changing product/category join table (:id is the product's id)

#### add_categoies 
Given an array of cetgories we want to add to product 
```json
  // params for add_categories with sample data
  "product_categories": [2,3], // array of category ids 
  "product_id": 1
```
add_categories will create an entry in product/category join table for every category 
Note: Contraints are added so that this method will throw error if user attempt to add same category to a product more than once 

### Category 

* `GET /categories` - return all categories 
* `POST /categories` - create a category 
* `DELETE /categories` - delete a category 

### Order

* `GET /orders` - return all orders, and order items from join table
* `POST /orders` - create an order 
Order create checks product inventory, if it does decrements product inventory and create entry in 
product/order join table 
```json 
  // params for orders create with sample data
  "customer_id": 1,
  "order_items": [1,2,2,3,3,3,4] 
```
for each element in the order_items array, orders create will check if product has enough inventory , if it does, then decrements product inventory and create entry in product/order join table 
* `GET /orders/shipt_search/:id` - returns json result based on the format wanted in prompt as shown below:

| customer id   | customer first name | category id | category name | number purchased |
| ------------  | ------------------- | --------    |  ----------   | ---------------- |
| 1             |         John        |      1      | Bouquets      |        15        |

### Order Item 

* `GET /orderitems` - return all order ids
* `POST /orderitems/search_by_date_range` - return number of orders by date range 

```json
  // params for orderitems search_by_date_range with sample data
  "start_date": "2017-12-16",
  "end_date": "2017-12-30",
  "range": "day" // day, month or year
```

* `POST /orderitems/search_by_date_range.csv` - return number of orders by date range in csv

```ruby 
  # provide a list of data and column names to build csv
  def self.to_csv(list, column_names)
    CSV.generate do |csv|
      csv << column_names

      list.each do |order_item|
        csv << order_item.values_at(*column_names)
      end
    end
  end
```







