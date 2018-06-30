class Admin::TypeProductsController < Admin::BaseController
  helper_method :sort_col, :sort_dir
  before_action :load_type_product, except: [:index, :new, :create]
  def index
    @type_products = TypeProduct.search(params[:search])
                                .order("#{sort_col} #{sort_dir}")
                                .page(params[:page])
                                .per Settings.page.per
  end

  def update
    if @type_product.update_attributes type_product_params
      flash[:success] = t ".success"
      redirect_to admin_type_products_url
    else
      render :edit
    end
  end

  def destroy
    if @type_product.destroy
      flash[:success] = t ".success"
      redirect_to admin_type_products_url
    else
      flash.now[:warning] = t ".warning"
    end
  end

  def sort_col
    TypeProduct.column_names.include?(params[:sort]) ? params[:sort] : "size"
  end

  private

  def type_product_params
    params.require(:type_product).permit :product_id, :quantity, :size,
      :color
  end

  def load_type_product
    @type_product = TypeProduct.find_by id: params[:id] || not_found
  end
end
