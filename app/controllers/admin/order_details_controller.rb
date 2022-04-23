class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail=OrderDetail.find(params[:id])
    if order_detail_params[:making_status]=="in_production"
      order_detail.update(making_status: "under_construction")
    end
    
    order=order_detail.order
    cake=0
    
    order.order_details.each do |good|
      if good.making_status=="in_production"
        cake+=1
      end
      end
      if cake>=1
        order.update(status: "under_construction")
        cake=0
      end
    order_detail.update(making_status: order_detail_params[:making_status])
    redirect_to admin_order_path(order_detail)
  end
   private
  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :making_status)
  end
end
