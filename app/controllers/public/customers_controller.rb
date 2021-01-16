class Public::CustomersController < ApplicationController

  before_action :authenticate_customer!

  def show
  end

  def edit
  end

  def update
    if current_customer.update(customer_params)
      redirect_to customer_params
    else
      render :edit
    end
  end

  def leave
  end

  def resign
    current_customer.update(customer_params)
    redirect_to root_path

  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_active)
  end

end
