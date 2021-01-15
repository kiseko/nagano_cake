class Admin::OrderItemsController < ApplicationController

  def update
    @order_item = OrderItem.find(params[:id])
    if @order_item.update(order_item_params)
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
