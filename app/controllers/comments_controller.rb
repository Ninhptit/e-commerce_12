class CommentsController < ApplicationController
  before_action :load_product, only: %i(create destroy)
  def create
    if current_user
      @comment = build_comment
      @error = @comment.errors.full_messages.join("\n") unless @comment.save
    else
      @error = t ".please_login"
    end
    @comments = load_comment
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment = Comment.find_by id: params[:id] || not_found
    @comment.destroy
    @comments = load_comment
    respond_to do |format|
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment)
          .permit(:description).merge user_id: current_user.id
  end

  def load_product
    @product = Product.find_by(id: params[:product_id]) || not_found
  end

  def load_comment
    @product.comments.order(created_at: :desc)
            .page(params[:page])
            .per Settings.comment.page.per
  end

  def build_comment
    @product.comments.build comment_params
  end
end
