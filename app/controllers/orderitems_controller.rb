class OrderitemsController < ApplicationController

  protect_from_forgery
  
  def index 
    @ordered_items = OrderItem.all
  end 

  def search_by_date_range
    # grab params
    start_date = Time.zone.parse(params[:start_date])
    end_date = Time.zone.parse(params[:end_date])
    range = params[:range]
    @result = OrderItem.find_by_date(start_date, end_date, range)
  end
end
