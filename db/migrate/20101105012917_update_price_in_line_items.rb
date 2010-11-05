class UpdatePriceInLineItems < ActiveRecord::Migration
  def self.up
    LineItem.all.each do |item|
      item.price = item.product.price
      item.save
    end
  end

  def self.down
    LineItem.all.each do |item|
      item.price = nil
      item.save
    end
  end
end
