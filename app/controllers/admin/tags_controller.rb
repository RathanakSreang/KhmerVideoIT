class Admin::TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :load_tag, only: [:show, :edit, :update]
  layout "admin/application"

  def show
    
  end

  def index
    if params[:search]
      @tags = Tags.search(params[:search]).order("created_at DESC").paginate page: params[:page], per_page: 7
    else
      @tags = Tag.order("created_at DESC").paginate page: params[:page], per_page: 7
    end    
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new tag_params
    if @tag.save
      flash[:success] = "Successful create"
      redirect_to [:admin, @tag]
    else
      flash.now[:danger] = "Fail create"
      render "new"
    end
  end

  def edit 
  end

  def update
    if @tag.update_attributes tag_params
      flash[:success] = "Successful update"
      redirect_to [:admin, @tag]
    else
      flash.now[:danger] = "Fail update"
      render "edit"
    end
  end

  def destroy
    @tag = Tag.find params[:id]
    @tag.destroy
    flash[:success] = "Successful delete"
    redirect_to admin_tags_path
  end

  private
  def load_tag
    @tag = Tag.find params[:id]
  end

  def tag_params
    params.require(:tag).permit :id, :name
  end

  def admin_user
    redirect_to root_url unless current_user.admin? 
  end
end
