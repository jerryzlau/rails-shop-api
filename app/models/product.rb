# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  price       :float            not null
#  weight      :float            not null
#  category_id :integer          not null
#  order_id :integer          
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  validates: :name, :price, :weight, :category_id, presence: true

  belongs_to :category,
  primary_key: :id,
  foreign_key: :category_id,
  class_name: :Category 

  belongs_to :order,
  primary_key: :id,
  foreign_key: :order_id,
  class_name: :Order

  has_many :categories,
  through: :category,
  source: :products
end
