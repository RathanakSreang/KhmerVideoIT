class Admin::VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  layout "admin/application"

  def show
    @video = Video.friendly.find params[:id]
  end

  def index    
    if params[:search]
      @videos = Video.search(params[:search]).order("created_at DESC").paginate page: params[:page], per_page: 7
    else
      @videos = Video.order("created_at DESC").paginate page: params[:page], per_page: 7
    end
  end

  def new
    @video = current_user.videos.new
    @video.build_snippet
  end

  def create
    @video = current_user.videos.new video_params
    if @video.save
      track_activity @video
      flash[:success] = t "flash.success_create"
      redirect_to [:admin, @video]
    else
      flash.now[:danger] = t "flash.fail_create"
      render "new"
    end
  end

  def edit
    @video = Video.friendly.find params[:id]
  end

  def update
    @video = Video.friendly.find params[:id]
    if @video.update_attributes video_params      
      flash[:success] = t "flash.success_update"
      track_activity @video
      redirect_to [:admin, @video]
    else
      flash.now[:danger] = t "flash.fail_update"
      render "edit"
    end
  end

  def destroy
    @video = Video.friendly.find params[:id]
    @video.destroy
    track_activity @video
    flash[:success] = t "flash.success_delete"
    redirect_to admin_videos_path
  end

  private
  def video_params
    params.require(:video).permit :id, :title, :image, :image_cache, :description,
                                  :link, :file_link, :duration,
                                  usefull_links_attributes: [:id, :title, :link, :_destroy],
                                  snippet_attributes: [:id, :content], tag_ids:[]

  end

  def admin_user
    redirect_to root_url unless current_user.admin? || current_user.super?
  end
end
