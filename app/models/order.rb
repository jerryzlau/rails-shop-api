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

  validates: :status, presence: true, inclusion: { in: ['waiting for delivery', 'on its way', 'delivered']}
  validtes: :customer_id, presence: true 

  belongs_to :customer,
  primary_key: :id,
  foreign_key: :customer_id,
  class_name: :User

  has_many :products,
  primary_key: :id,
  foreign_key: :order_id,
  class_name: :Product
end
