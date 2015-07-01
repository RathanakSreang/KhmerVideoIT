class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :load_user, only: [:show, :edit, :update]
  layout "admin/application"

  def show    
  end

  def index
   if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
                   .paginate page: params[:page], per_page: 7
    else
      @users = User.order("created_at DESC").paginate page: params[:page], per_page: 7
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    @user.skip_confirmation!
    if @user.save
      track_activity @user
      flash[:success] = "Successful create"
      redirect_to [:admin, @user]
    else
      flash.now[:danger] = "Fail create"
      render "new"
    end
  end

  def edit    
  end

  def update
    if @user.update_without_password user_params
      track_activity @user
      flash[:success] = "Successful update"
      redirect_to [:admin, @user]
    else
      flash.now[:danger] = "Fail update"
      render "edit"
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    track_activity @user
    flash[:success] = "Successful delete"
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :id, :name, :role, :avatar, :avatar_cache,
                                  :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find params[:id]
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
