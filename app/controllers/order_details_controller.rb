class OrderDetailsController < ApplicationController
  before_action :find_order_detail, only: [:update, :destroy]

  def update
    type_product = TypeProduct.find_by id: params[:type_product_id]
    if type_product.present?
      update_order_detail type_product
    else
      flash[:warning] = "This product is not available"
    end
    respond_to do |format|
      format.html{redirect_to orders_url}
    end
  end

  def destroy
    @id = params[:id]
    @order = @order_detail.order
    @order_detail.destroy
    @order.destroy if @order.order_details.first.nil?
    respond_to do |format|
      format.js
    end
  end

  private
  def find_order_detail
    @order_detail = OrderDetail.find_by id: params[:id] || not_found
  end

  def update_order_detail type_product
    if type_product.check_quantity(params[:quantity].to_i)
      if @order_detail.update_attributes(quantity: params[:quantity], type_product_id: params[:type_product_id])
        flash[:warning] = "updated successfully"
      else
        flash[:warning] = "Update unsuccessful"
      end
    else
      flash[:warning] = "Only " << type_product.quantity.to_s << " products"
    end
  end
end
