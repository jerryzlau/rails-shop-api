class OrderitemsController < ApplicationController

  def index 
    @ordered_items = OrderItem.all
  end 

  def search_by_date_range
    # grab params
    start_date = Time.zone.parse(params[:start_date])
    end_date = Time.zone.parse(params[:end_date])

    # collect items that are within timeframe
    within_range = OrderItem.find_by_date(start_date, end_date)
    
    # build result based on range 
    current_date = start_date
    @result = {}
    if params[:range] == 'day'
      # build the hash with dates as keys
      until current_date > end_date
        current_date.to_date
        @result[current_date.to_date] = []
        current_date += 1
      end 

      # push items with relevant date to hash accordingly 
      within_range.each do |item|
        item_date = item.created_at.to_date
        @result[item_date] << item.product if @result[item_date] 
      end 

    elsif params[:range] == 'week'
      # build hash in weeks intervel
      until current_date > end_date
        @result[current_date.to_date] = [] 
        current_date += 7 
      end 

      # push items with relevant date to hash accordingly
      counter = 0
      within_range.each do |item|
        item_date = item.created_at.to_date
        if counter <= 7
          @result[item_date - counter] << item 
          counter += 1
        else 
          counter = 0
        end 
      end 
    elsif params[:range] == 'month'

    end 
    @result
  end
end
