class Admin::PromotionsController < Admin::BaseController
  helper_method :sort_col, :sort_dir
  before_action :load_promotion, except: [:index, :new, :create]
  def index
    @promotions = Promotion.search(params[:search])
                           .order("#{sort_col} #{sort_dir}")
                           .page(params[:page])
                           .per Settings.page.per
  end

  def show; end

  def new
    @promotion = Promotion.new
    @promotion.product_promotions.build
  end

  def create
    @promotion = Promotion.new promotion_params
    if @promotion.save
      flash[:success] = t ".success"
      redirect_to admin_promotions_url
    else
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy; end

  def sort_col
    Promotion.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  private
  def promotion_params
    params.require(:promotion).permit :name, :description, :start_date,
      :end_date, product_promotions_attributes: [:product_id, :percent]
  end

  def load_promotion
    @promotion = Promotion.find_by(id: params[:id]) || not_found
  end
end
