class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail=OrderDetail.find(params[:id])
    order_detail.update(making_status: order_detail_params[:making_status])
    order=order_detail.order
    cake=0
    cookie=0
    order.order_details.each do |good|
      if good.making_status=="in_production"
        cake+=1
      end
    end
      if cake>=1
        order.update(status:2)
        cake=0
      end
    order.order_details.each do |apple|
      if apple.making_status=="production_completed"
        cookie+=1
      end
    end
      if cookie==order.order_details.count
        order.update(status:3)
        cookie=0
      end
    redirect_to admin_order_path(order.id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :making_status)
  end
end
