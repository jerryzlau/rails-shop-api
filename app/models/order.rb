# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  status      :string           default("waiting for delivery"), not null
#  customer_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Order < ApplicationRecord

  validates :status, presence: true, inclusion: { in: ['waiting for delivery', 'on its way', 'delivered']}
  validates :customer_id, presence: true 

  belongs_to :customer,
  primary_key: :id,
  foreign_key: :customer_id,
  class_name: :User

  has_many :ordered_items,
  primary_key: :id,
  foreign_key: :order_id,
  class_name: :OrderItem

  has_many :products,
  through: :ordered_items,
  source: :product

  def self.query 
    
    sql = "SELECT u.id AS user_id, u.first_name, c.id, c.name AS category_name, COUNT(c.id) AS number_purchased
    FROM users u
    JOIN orders o ON u.id = o.customer_id
    JOIN order_items oi ON o.id = oi.order_id
    JOIN products p ON p.id = oi.product_id
    JOIN product_categories pc ON pc.product_id = p.id
    JOIN categories c ON c.id = pc.category_id
    GROUP BY u.id, c.id"

    ActiveRecord::Base.connection.execute(sql)
  end 
end
