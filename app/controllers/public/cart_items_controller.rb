class Public::CartItemsController < ApplicationController
  def index
    @cart_items=current_customer.cart_items

  end
  def create
    @cart_item=CartItem.new(cart_item_params)
    @cart_item.save
    redirect_to cart_item_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :customer_id, :item_id)
  end
end
