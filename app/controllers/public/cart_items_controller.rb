class Public::CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to cart_items_path
    else
       @item = Item.find(@cart_item.item_id)
      render template: "public/items/show"
    end
  end

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      @cart_items = CartItem.where(customer_id: current_customer.id)
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
     @cart_items = CartItem.where(customer_id: current_customer.id)
     @cart_items.destroy_all
     redirect_to cart_items_path
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
