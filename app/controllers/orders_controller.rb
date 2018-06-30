class OrdersController < ApplicationController
  def index
    @order = current_user.orders.unpaid.first
  end

  def create
    @message = ""
    order = current_user.orders.unpaid.first
    if order.present?
      create_cart order
    else
      order = current_user.orders.new(order_params)
      @message = if order.save
                    "Add to cart successfully"
                 else
                    "Add to cart unsuccessful"
                 end
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def order_params
    params.require(:order).permit order_details_attributes: [:type_product_id,
      :price, :quantity]
  end

  def order_detail_params
    order_params[:order_details_attributes]["0"]
  end

  def create_cart order
    order_detail = order.order_details.find_type_product(order_detail_params[:type_product_id].to_i).first
    quantity_params = order_detail_params[:quantity].to_i
    if order_detail.present?
      if quantity_params > 0
        update_quantity quantity_params
      else
        @message = "Add to cart unsuccessful"
      end
    else
      order_detail = order.order_details.new(order_detail_params)
      @message = if order_detail.save
                    "Add to cart successfully"
                 else
                    "Add to cart unsuccessful"
                 end
    end
  end

  def update_quantity quantity_params
    quantity = order_detail.quantity + quantity_params
    @message = if order_detail.update_attributes(quantity: quantity)
                  "Add to cart successfully"
                else
                  "Add to cart unsuccessful"
                end
  end
end
