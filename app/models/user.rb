# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  validates :first_name, :last_name, presence: true

  has_many :orders,
  primary_key: :id,
  foreign_key: :customer_id,
  class_name: :Order
end
