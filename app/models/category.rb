# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :product_categories,
  primary_key: :id,
  foreign_key: :category_id,
  class_name: :ProductCategory

  has_many :products,
  through: :product_categories,
  source: :product

end
