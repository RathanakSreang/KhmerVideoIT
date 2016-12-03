class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :load_user, only: [:show, :edit, :update]
  layout "admin/application"

  def show
  end

  def index
    @users = User.order(created_at: :desc).paginate page: params[:page], per_page: 7
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    @user.skip_confirmation!
    if @user.save
      track_activity @user
      flash[:success] = t "flash.success_create"
      redirect_to [:admin, @user]
    else
      flash.now[:danger] = t "flash.fail_create"
      render "new"
    end
  end

  def edit
  end

  def update
    var_param = user_params
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      var_param = user_params_without_pass
    end
    if @user.update_attributes var_param
      track_activity @user
      flash[:success] = t "flash.success_update"
      redirect_to [:admin, @user]
    else
      flash.now[:danger] = t "flash.fail_update"
      render "edit"
    end
  end

  def destroy
    @user = User.friendly.find params[:id]
    @user.destroy
    track_activity @user
    flash[:success] = t "flash.success_delete"
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :id, :name, :role, :avatar, :avatar_cache,
                                  :email, :password, :password_confirmation
  end

  def user_params_without_pass
    params.require(:user).permit :id, :name, :role, :avatar, :avatar_cache,
                                  :email
  end

  def load_user
    @user = User.friendly.find params[:id]
  end

  def admin_user
    redirect_to root_url unless current_user.admin? || current_user.super?
  end
end
