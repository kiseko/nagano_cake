class Public::HomesController < ApplicationController

  def top
    @active_items = Item.where(is_active: :true)
    @items = @active_items.order(id: :desc).limit(4)
  end

  def about
  end

end
