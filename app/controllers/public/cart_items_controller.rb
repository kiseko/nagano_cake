class Public::CartItemsController < ApplicationController
  
  def create
    @cart_item = CartItem.new
    @cart_item.customer_id = current_customer.id
    redirect_to cart_items_path
  end
  
  def index
  end
  
  def update
  end
  
  def destroy
  end
  
  def destroy_all
  end
  
end
