class OrdersController < ApplicationController

  def index 
    @orders = Order.all
  end 

  def create
  end

  def shipt_search
    @order = Order.find(params[:id])
    @customer = @order.customer
    @products = @order.products
    @categories = []
    @products.each do |product|
      product.categories.each do |category|
        @categories << category if !@categories.include?(category)
      end 
    end 
  end 

  private 

  def order_params
    params.require(:order).permit(:status, :customer_id)
  end 
end
