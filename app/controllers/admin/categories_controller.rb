class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, except: %i(index new create)
  helper_method :sort_col, :sort_dir
  def index
    @categories = Category.search(params[:search])
                          .order("#{sort_col} #{sort_dir}")
                          .page(params[:page])
                          .per Settings.page.per
  end

  def new
    @category = current_user.categories.build
  end

  def create
    @category = current_user.categories.build category_params
    if @category.save
      flash[:success] = t ".success"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".success"
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".success"
      redirect_to admin_categories_url
    else
      flash.now[:warning] = t ".warning"
    end
  end

  def sort_col
    Category.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  private
  def load_category
    @category = Category.find_by id: params[:id] || not_found
  end

  def category_params
    params.require(:category).permit :name
  end
end
