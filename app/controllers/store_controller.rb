class StoreController < ApplicationController
  def index
    @products = Product.all
    @count = increment_count
  end
  
  private
  def increment_count
    session[:counter] ||= 0
    session[:counter] += 1
  end
end
