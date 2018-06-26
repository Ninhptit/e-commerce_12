class ProductsController < ApplicationController
  def index
    @products = Product.order_by_time
                       .page(params[:page]).per Settings.products.index.per_page
  end

  def show
    @product = Product.find_by id: params[:id] || not_found
  end
end
