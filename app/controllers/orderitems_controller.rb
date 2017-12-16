class OrderitemsController < ApplicationController

  def index 
    @ordered_items = OrderItem.all
  end 

  def search_by_date_range
    p params
    @ordered_items = OrderItem.all
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    @daily = []
    weekly = []
    yearly = []
    OrderItem.all.each do |item|
      item_date = Date.parse(item.created_at.to_s[0..9])
      # looking for within a day 
      if start_date == end_date
        if item_date == start_date
          @daily << item.product
        end 
      end 
    end 

    @daily
  end
end
