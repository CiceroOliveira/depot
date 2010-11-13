class PayType < ActiveRecord::Base
  default_scope :order => 'pay_type'
  
  def self.get_pay_types
    pay_types = []
    PayType.all.each do |pt|
      pay_types << pt.pay_type
    end
    pay_types
  end
end
