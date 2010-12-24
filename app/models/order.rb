class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  
  PAYMENT_TYPES = [I18n.t(".cheque"),I18n.t(".credit_card"),I18n.t(".purchase_order")]
  #PAYMENT_TYPES = PayType.get_pay_types
  
  validates :name, :address, :email, :pay_type, :presence => true
  validates :pay_type, :inclusion => PAYMENT_TYPES
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
