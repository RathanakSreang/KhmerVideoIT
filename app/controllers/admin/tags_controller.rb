class Admin::TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :load_tag, only: [:show, :edit, :update]
  layout "admin/application"

  def show
    @videos = @tag.videos.order("created_at DESC")
                  .includes(:user)
                  .paginate page: params[:page], per_page: 7
    @articles = @tag.articles.order("created_at DESC")
                  .includes(:user)
                  .paginate page: params[:page], per_page: 7
  end

  def index
    if params[:search]
      @tags = Tag.search(params[:search])
              .includes(:user)
              .paginate page: params[:page], per_page: 7
    else
      @tags = Tag.order("created_at DESC")
      .includes(:user)
      .paginate page: params[:page], per_page: 7
    end
  end

  def new
    @tag = current_user.tags.new
  end

  def create
    @tag = current_user.tags.new tag_params
    if @tag.save
      track_activity @tag
      flash[:success] = t "flash.success_create"
      redirect_to [:admin, @tag]
    else
      flash.now[:danger] = t "flash.fail_create"
      render "new"
    end
  end

  def edit
  end

  def update
    if @tag.update_attributes tag_params
      track_activity @tag
      flash[:success] = t "flash.success_update"
      redirect_to [:admin, @tag]
    else
      flash.now[:danger] = t "flash.fail_update"
      render "edit"
    end
  end

  def destroy
    @tag = Tag.friendly.find params[:id]
    @tag.destroy
    track_activity @tag
    flash[:success] = t "flash.success_delete"
    redirect_to admin_tags_path
  end

  private
  def load_tag
    @tag = Tag.includes(:user).friendly.find params[:id]
  end

  def tag_params
    params.require(:tag).permit :id, :name
  end

  def admin_user
    redirect_to root_url unless current_user.admin? || current_user.super?
  end
end
