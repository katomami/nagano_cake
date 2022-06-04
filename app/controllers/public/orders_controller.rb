class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    cart_items=current_customer.cart_items.all
    @order=current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_detail=OrderDetail.new
        order_detail.item_id=cart.item_id
        order_detail.order_id=@order.id
        order_detail.amount=cart.amount
        order_detail.price=cart.item.with_tax_price
        order_detail.save
      end
      #@order.shipping_cost=800
      @total=0
      cart_items.each do |cart_item|
        cart_item.subtotal
        @total += cart_item.subtotal
      end
      @order.total_payment=@total+800
      redirect_to orders_thanks_path
      cart_items.destroy_all
    else
      @order=Order.new(order_params)
      render :new
    end
  end

  def confirm
    @order=Order.new(order_params)
    @order.shipping_cost=800
    @cart_items=current_customer.cart_items
    @order.payment_method=params[:order][:payment_method]
    if params[:order][:select_address]=="0"
      @order.address=current_customer.address
      @order.postal_code=current_customer.postal_code
      @order.name=current_customer.last_name+current_customer.first_name
    elsif params[:order][:select_address]=="1"
      @address=Address.find(params[:order][:address_id])
      @order.postal_code=@address.postal_code
      @order.address=@address.address
      @order.name=@address.name
    elsif params[:order][:select_address]=="2"
      @order.postal_code=params[:order][:postal_code]
      @order.address=params[:order][:address]
      @order.name=params[:order][:name]
    end
    #@total=0
    #@cart_items.each do |cart_item|
      #cart_item.subtotal
      #@total += cart_item.subtotal
    #end
    #@order.total_payment=@total
  end

  def index
    @orders=current_customer.orders
  end

  def show
    @order=Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :customer_id, :cart_item_id, :shipping_cost, :total_payment)
  end
end
