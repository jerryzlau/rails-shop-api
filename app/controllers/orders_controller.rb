class OrdersController < ApplicationController

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
      # check if the shopping cart is empty
      if order_items.empty? 
        render json: ["Order is empty!"], status: 422
      end 
      # check if Product has inventory 

      
      # create the order and decrement the product inventory 
    end 
  end

  def check_inventory(order_items)

  end 

  def update 

  end 

  def shipt_search
    @order = Order.find(params[:id])
    if @order 
      @customer = @order.customer
      @products = @order.products
      @categories = []
      @products.each do |product|
        product.categories.each do |category|
          @categories << category if !@categories.include?(category)
        end 
      end 
    else 
      render json: ["Order doesn't exist"], status: 404
    end 
  end 

  private 

  def order_params
    params.require(:order).permit(:status, :customer_id)
  end 
end
