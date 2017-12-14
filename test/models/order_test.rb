# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  status      :string           default("waiting for delivery"), not null
#  product_id  :integer          not null
#  customer_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
