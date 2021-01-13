class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save
    redirect_to thank_order_path
  end

  def index
  end

  def show
  end

  def confirm
    @order = current_customer.orders.new(order_params)
    if params[:select_address] == "customer_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:select_address] == "registration_address"
      @address = Address.find(params[:r_ad][:registration_address])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name =@address.name
    elsif params[:select_address] == "new_address"
    end

    @cart_items = current_customer.cart_items
    @order.postage = 800
    render action: :confirm

  end

  def thank
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :total_price, :postage, :status, :name, :postal_code, :address)
  end

end
