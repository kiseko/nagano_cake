class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def create
    @order = Order.new(order_params)
    if @order.customer_id == current_customer.id
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif @order.postage.present?
      @address = Address.find_by(id: @order.postage)
      @order.customer_id = current_customer.id
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name =@address.name
    else
      @order.customer_id = current_customer.id
    end
    render action: :confirm

  end

  def index
  end

  def show
  end

  def confirm
  end

  def thank
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :total_price, :postage, :status, :name, :postal_code, :address)
  end

end
