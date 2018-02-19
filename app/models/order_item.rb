# == Schema Information
#
# Table name: order_items
#
#  id          :integer          not null, primary key
#  order_id    :integer          not null
#  product_id  :integer           not null     
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class OrderItem < ApplicationRecord
  validates :order_id, :product_id, presence: true

  belongs_to :order,
  primary_key: :id,
  foreign_key: :order_id,
  class_name: :Order 

  belongs_to :product,
  primary_key: :id,
  foreign_key: :product_id,
  class_name: :Product

  # query to return search result by date range
  # returns number of orders by date range provided
  def self.find_by_date(start_date, end_date, range)
    OrderItem.where("DATE(created_at) BETWEEN ? AND ?","%#{start_date}%", "%#{end_date}%")
             .group("DATE(DATE_TRUNC('#{range}', created_at))").count
  end 

  # provide a list of data and column names to build csv
  def self.to_csv(list, column_names)
    CSV.generate do |csv|
      csv << column_names

      list.each do |order_item|
        csv << order_item.values_at(*column_names)
      end
    end
  end
end
