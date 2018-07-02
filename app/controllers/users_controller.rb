class UsersController < ApplicationController
  before_action :load_user, except: %i(new create)

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_mail_active"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params_info
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def user_params_info
    params.require(:user).permit :name, :email, :address,
      :birthday, :phone, :avatar
  end

  def load_user
    @user = User.find_by id: params[:id] || not_found
  end
end
