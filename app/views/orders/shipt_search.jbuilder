json.customer_id @customer.id
json.customer_first_name @customer.first_name 
json.categories_id @categories.map {|category| category.id}.uniq
json.categories_names @categories.map {|category| category.name}.uniq
json.number_purchased @products.length
json.products @products