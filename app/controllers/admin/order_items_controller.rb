class Admin::OrderItemsController < ApplicationController

  before_action :authenticate_admin!

  def update
    @order_item = OrderItem.find(params[:id])
    if @order_item.update(order_item_params)
      @order_items = OrderItem.where(order_id: @order_item.order_id)
      @finish_order_items = @order_items.where(production_status: "製作完了")
      if @finish_order_items.length == @order_items.length
        @order = Order.find(@order_item.order_id)
        @order.update(status: "発送準備中")
      end
      redirect_to admin_order_path(@order_item.order_id)
    else
      Order.find(@order_item.order_id)
      render template: "admin/orders/show"
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:production_status)
  end

end
