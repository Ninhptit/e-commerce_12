class OrderDetailsController < ApplicationController
  before_action :find_order_detail, only: [:update, :destroy]

  def update
    type_product = TypeProduct.find_by id: params[:type_product_id]

    if type_product.present?
      if type_product.check_quantity(params[:quantity].to_i)
        flash[:warning] = "Update khong thanh cong" unless @order_detail.update_attributes(quantity: params[:quantity], type_product_id: params[:type_product_id])
      else
        flash[:warning] = "Chi con " << type_product.quantity.to_s << " san pham"
      end
    else
      flash[:warning] = "Khong co san pham nay"  
    end
    respond_to do |format|
      format.html { redirect_to orders_path}
    end
  end

  def destroy
    @id = params[:id]
    @order_detail.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def find_order_detail
    @order_detail = OrderDetail.find_by id: params[:id] || not_found
  end
end
