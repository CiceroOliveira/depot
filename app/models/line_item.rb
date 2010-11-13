class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  
  def total_price
    product.price * quantity
  end
  
  def total_items
    quantity
  end
  
  def delete_one
    current_item = self
    current_item.quantity -= 1
    if current_item.quantity == 0
      current_item.destroy
    else
      current_item.save
    end
  end
end
