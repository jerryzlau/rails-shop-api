class OrderitemsController < ApplicationController

  def index 
    @ordered_items = OrderItem.all
  end 
end
