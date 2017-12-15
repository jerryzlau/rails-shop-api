# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  price       :float            not null
#  weight      :float            not null       
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  validates :name, :price, :weight, presence: true

  has_many :product_categories,
  primary_key: :id,
  foreign_key: :product_id,
  class_name: :ProductCategory

  has_many :categories,
  through: :product_categories,
  source: :category

  has_many :ordered_items,
  primary_key: :id,
  foreign_key: :product_id,
  class_name: :OrderItem

  has_many :orders,
  through: :ordered_items,
  source: :order

end
