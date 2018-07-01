class ProductsController < ApplicationController
  before_action :logged_in_user

  def index
    @products = Product.order_by_time
                       .page(params[:page]).per Settings.products.index.per_page
  end

  def show
    @product = Product.find_by id: params[:id] || not_found
    @order = current_user.orders.new
    order_detail = @order.order_details.build
  end

  private
  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".please_login"
    redirect_to login_path
  end
end
