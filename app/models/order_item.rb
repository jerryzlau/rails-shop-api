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

require 'csv'

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

  # use queries to return search result
  def self.find_by_date(start_date, end_date, range)
    # OrderItem.where("DATE(created_at) BETWEEN ? AND ?","%#{start_date}%", "%#{end_date + 1.day}%")
    #   .group("DATE(DATE_TRUNC('#{range}', created_at))").count
    OrderItem.select("*")
      .where("DATE(created_at) BETWEEN ? AND ?","%#{start_date}%", "%#{end_date + 1.day}%")
      .group("DATE(DATE_TRUNC('#{range}', created_at))").count
  end 

  # function to export as csv
  def self.to_csv(list)
    # built specifically for question 5 
    column_names = ['date', 'num_orders']

    CSV.generate do |csv|
      csv << column_names

      list.each do |order_item|
        temp = []
        column_names.each do |name|
          temp << order_item[name.to_sym]
        end 
        csv << temp
      end
    end
  end
end
