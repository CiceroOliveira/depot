require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  
  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)
  
    # A user goes to the store index page.
    get "/"
    assert_response :success
    assert_template "index"
  
    # The user selects a product, adding it to the cart
    xml_http_request :post, '/line_items', :product_id => ruby_book.id
    assert_response :success
  
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product
  
    # Then he checks out...
    get '/orders/new'
    assert_response :success
    assert_template "new"
  
    # ...fills his details in the checkout form
    post_via_redirect "/orders",
                      :order    => {:name => "Dave Thomas",
                      :address  => "123 Main St.",
                      :email    => "dave@example.com",
                      :pay_type => "Cheque" }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size
  
    #... one order is created...
    orders = Order.find(:all)
    assert_equal 1, orders.size
    order = orders[0]
  
    #...containing his information...
    assert_equal "Dave Thomas", order.name
    assert_equal "123 Main St.", order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Cheque", order.pay_type
  
    #... one line item is created...
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product
    
    #an email is sent.
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    assert_equal 'Pragmatic Store Order Confirmation', mail.subject
    
    put "/orders/#{order.id}",
                :order    => {:ship_date => Time.now }
    mail = ActionMailer::Base.deliveries.last
    assert mail    
  end

end
