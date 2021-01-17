class Public::ItemsController < ApplicationController

  def index
    @active_items = Item.where(is_active: :true)
    @items = @active_items.page(params[:page]).per(12)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
