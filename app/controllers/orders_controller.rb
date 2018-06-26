class OrdersController < ApplicationController
  def index
    @order = current_user.orders.unpaid.first
  end

  def create
    @order = current_user.orders.unpaid.first
    if @order.present?
      order_detail = @order.order_details.find_type_product(order_params[:order_details_attributes]["0"][:type_product_id].to_i).first
      if order_detail.present?
        quantity = order_detail.quantity +  order_params[:order_details_attributes]["0"][:quantity].to_i
        order_detail.update_attributes(:quantity => quantity)
      else
        @order.order_details.create(type_product_id: order_params[:order_details_attributes]["0"][:type_product_id].to_i,
                                    quantity: order_params[:order_details_attributes]["0"][:quantity].to_i,
                                    price: order_params[:order_details_attributes]["0"][:price].to_i)
      end  
    else
      @order = current_user.orders.create(order_params)
    end

    respond_to do |format|
      format.js
    end
  end
  
  private
  def order_params
    params.require(:order).permit order_details_attributes: [:type_product_id, :price, :quantity]
  end

end
