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
    orders_by_date = OrderItem.find_by_date(start_date, end_date, range)
    # @orders = OrderItem.find_by_date(start_date, end_date, range)

    # format for csv 
    csv_hash = []
    orders_by_date.each do |k,v|
      temp_hash = {}
      temp_hash[:date] = k
      temp_hash[:num_orders] = v
      csv_hash << temp_hash
    end 

    # for jbuilder to display json
    @orders = csv_hash

    # generate csv file
    respond_to do |format|
      format.json # return json if not specifying file type
      # return csv if url ends with .csv
      format.csv { send_data OrderItem.to_csv(@orders), filename: "orderitems-#{start_date}-#{end_date}.csv" }
    end
  end
end
