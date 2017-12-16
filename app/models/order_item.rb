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

  # use queries to return search result
  def self.find_by_date(start_date, end_date)
    OrderItem.where("created_at BETWEEN ? AND ?", "%#{start_date}%", "%#{end_date + 1.day}%");
  end 
end
