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

  def search
    if params[:search_genre][:select_genre].empty?
      redirect_to items_path
    else
      @genres = Genre.all
      @genre = Genre.find(params[:search_genre][:select_genre])
      @select_items = Item.where(genre_id: params[:search_genre][:select_genre])
      @items = @select_items.page(params[:page]).per(12)
      render :index
    end
  end

end
