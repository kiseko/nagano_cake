class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  before_action :ensure_current_customer, {only: [:show]}
  def ensure_current_customer
    if current_customer.orders.exists?(params[:id])
    else
      redirect_to orders_path
    end
  end

  def new
    @order = Order.new
    @addresses = current_customer.addresses
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
    if @order.postal_code.presence && @order.address.presence && @order.name.presence
      render :confirm
    else
      @addresses = current_customer.addresses
      flash.now[:alert] = "--新しいお届け先に不備があります--"
      render :new
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    if @order.save

      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        @tax_included = (BigDecimal(cart_item.item.price) * BigDecimal("1.1")).ceil
        OrderItem.create(
          order_id: @order.id,
          item_id: cart_item.item.id,
          amount: cart_item.amount,
          purchase_price: @tax_included
        )
      end

      @cart_items.destroy_all
      redirect_to thank_order_path

    else
      @addresses = current_customer.addresses
      render :new
    end
  end

  def thank
  end

  def index
    @orders = current_customer.orders.page(params[:page]).per(10).reverse_order
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  #def destroy
    #@order = Order.find(params[:id])
    #@order.destroy
    #redirect_to orders_path
  #end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :total_price, :postage, :status, :name, :postal_code, :address)
  end

end
