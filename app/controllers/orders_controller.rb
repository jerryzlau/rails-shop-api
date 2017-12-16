class OrdersController < ApplicationController
  protect_from_forgery

  def index 
    @orders = Order.all
  end 

  def create
    customer_id = params[:customer_id]
    # order_items is going to be an array of product_id ex. [1,2,2,3,3]
    order_items = Hash.new(0)
    
    # put orders into a hash with value has number of item
    params[:order_items].each {|item| order_items[item] += 1}

    # check if there are customer ordering and items ordered
    if order_items && customer_id
      make_order(order_items, customer_id)
    else 
      render json: ["No Order Items or Cusomter Info"], status: 422
    end 
  end

  def make_order(order_items, customer_id)
    if can_make_order?(order_items)
      # create the order and decrement the product inventory 

      new_order = Order.create(customer_id: customer_id)
      order_items.each do |item_id, amount|
        OrderItem.create(product_id: item_id, order_id: new_order.id)
        product = Product.find(item_id)
        product.update_attributes(inventory: (product.inventory - amount))
      end 
    else 
      render json: ["Insufficient inventory"], status: 422
    end
  end 

  def can_make_order?(order_items)
    # check if Product has inventory 
    valid = true 
    order_items.each do |item_id, amount|
      valid = false if Product.find(item_id).inventory < amount 
    end 
    valid 
  end 

  def shipt_search
    @order = Order.find(params[:id])
    if @order 
      @customer = @order.customer
      @products = @order.products.uniq
      @categories = []
      @products.each do |product|
        product.categories.each do |category|
          @categories << category 
        end 
      end 
      @categories.uniq
    else 
      render json: ["Order doesn't exist"], status: 404
    end 
  end 

  private 

  def order_params
    params.require(:order).permit(:status, :customer_id)
  end 
end
