class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
  end

  def confirm
    @order=Order.new(order_params)
    @cart_items=current_customer.cart_items
    @order.payment_method=params[:order][:payment_method]
    if params[:order][:select_address]=="0"
      @order.address=current_customer.address
      @order.postal_code=current_customer.postal_code
      @order.name=current_customer.first_name+current_customer.last_name
      redirect_to orders_confirm_path
    elsif params[:order][:select_address]=="1"
      @address=Address.find(params[:order][:address_id])
      @order.postal_code=@address.postal_code
      @order.address=@address.address
      @order.name=@address.name
      redirect_to orders_confirm_path
    elsif params[:order][:select_address]=="2"
      @order.postal_code=params[:order][:postal_code]
      @order.address=params[:order][:address]
      @order.name=params[:order][:name] 
      @order.save
      redirect_to orders_confirm_path
    end
  end

  def thanks
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :customer_id)
  end
end
