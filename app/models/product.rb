# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  price       :float            not null
#  weight      :float            not null
#  order_id :integer          
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  validates :name, :price, :weight, presence: true

  belongs_to :order,
  primary_key: :id,
  foreign_key: :order_id,
  class_name: :Order

  has_many :product_categories,
  primary_key: :id,
  foreign_key: :product_id,
  class_name: :ProductCategory

  has_many :categories,
  through: :product_categories,
  source: :category


end
