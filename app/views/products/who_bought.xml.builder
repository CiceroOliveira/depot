xml.instruct!
xml.root do
xml.title @product.title

@product.orders.each do |order|
	xml.order do
	  xml.id order.id
	  
  	xml.shippedto do
  	  xml.name order.name
  	  xml.email order.email
  	  xml.address order.address
  	end
  	
  	xml.products do 
  	  order.line_items.each do |item|
  	    xml.product do
  	      xml.title item.product.title
  	      xml.quantity item.quantity
  	      xml.totalprice item.total_price, :currency => "USD"
	      end
	    end
    end
      
  	xml.total order.line_items.map(&:total_price).sum, :currency => "USD"
  	xml.paytype order.pay_type
	end
end
end