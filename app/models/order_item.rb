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
end
