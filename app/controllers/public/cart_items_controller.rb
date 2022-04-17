class Public::CartItemsController < ApplicationController
  def index
    @cart_items=current_customer.cart_items

  end
  def create
      @cart_item=CartItem.new(cart_item_params)
      @cart_item.customer_id=current_customer.id

      @cart = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      if @cart
      @cart.amount += params[:cart_item][:amount].to_i
      @cart.update_attribute(:amount, @cart.amount)
      @cart_item.delete
     end
      @cart_item.save
      redirect_to cart_item_path

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
