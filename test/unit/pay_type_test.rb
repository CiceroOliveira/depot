require 'test_helper'

class PayTypeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "return array of pay types" do
    pt = PayType.get_pay_types
    assert_equal ["Check","Credit Card","Purchase Order"], pt
  end
end
