json.orders @orders.each do |order|
  json.id order.id
  json.customer_id order.customer_id
  json.status order.status 
  json.total_price order.products.map {|p| p.price}.reduce(:+)
  json.total_weight order.products.map {|p| p.weight}.reduce(:+)
  json.products order.products
end 