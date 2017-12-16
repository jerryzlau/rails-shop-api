json.id @user.id
json.first_name @user.first_name
json.last_name @user.last_name
json.orders @user.orders.map do |order|
  json.order_status order.status
  json.order order.products 
end 