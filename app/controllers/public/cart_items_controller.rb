class Public::CartItemsController < ApplicationController
  def index
    @cart_items=current_customer.cart_items

  end
  def create
      @cart_item=current_customer.cart_items.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
	  if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to cart_item_path
    else
      @cart_item.save 
      redirect_to cart_item_path
  end
  end
  def update
    cart_item=CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_item_path(cart_item)
  end
  def destroy_all

    current_customer.cart_items.destroy_all

    redirect_to cart_item_path
  end
  def destroy
    cart_item=CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_item_path

  end
  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :customer_id, :item_id)
  end
end
