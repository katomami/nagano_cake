class Public::CustomersController < ApplicationController
  def show
    @customer=current_customer
  end

  def edit
     @customer=current_customer
  end

  def update
    current_customer.update(customer_params)
    redirect_to customers_path
  end

  def unsubscribe
  end

  def withdrawal
    @customer=current_customer
    @customer.update(is_active: true)
    reset_session
    redirect_to root_path
  end
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_active)
  end
end
