# == Schema Information
#
# Table name: product_categories
#
#  id          :integer          not null, primary key
#  category_id :integer          not null
#  product_id  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ProductCategory < ApplicationRecord
  validates :product_id, uniqueness: { scope: :category_id }, presence: true

  belongs_to :product,
  primary_key: :id,
  foreign_key: :product_id,
  class_name: :Product 

  belongs_to :category,
  primary_key: :id,
  foreign_key: :category_id,
  class_name: :Category
end
