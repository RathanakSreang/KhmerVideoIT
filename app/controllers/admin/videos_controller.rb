class Admin::VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  layout "admin/application"

  def show
    @video = Video.find params[:id]
  end

  def index    
    if params[:search]
      @videos = Video.search(params[:search]).order("created_at DESC").paginate page: params[:page], per_page: 7
    else
      @videos = Video.order("created_at DESC").paginate page: params[:page], per_page: 7
    end
  end

  def new
    @video = Video.new
    @video.build_snippet
  end

  def create
    @video = Video.new video_params
    if @video.save
      flash.now[:success] = "successful Create"
      redirect_to [:admin, @video]
    else
      flash.now[:danger] = "Fail Create"
      render "new"
    end
  end

  def edit
    @video = Video.find params[:id]
  end

  def update
    @video = Video.find params[:id]
    if @video.update_attributes video_params
      flash.now[:success] = "successful update"
      redirect_to [:admin, @video]
    else
      flash.now[:danger] = "Fail Update"
      render "edit"
    end
  end

  def destroy
    @video = Video.find params[:id]
    @video.destroy
    flash.now[:success] = "successful dalate"
    redirect_to admin_videos_path
  end

  private
  def video_params
    params.require(:video).permit :id, :title, :image, :image_cache, :description,
                                  :link, :file, :file_cache, :duration,
                                  usefull_links_attributes: [:id, :title, :link, :_destroy],
                                  snippet_attributes: [:id, :content], tag_ids:[]

  end

  def admin_user
    redirect_to root_url unless current_user.admin? 
  end
end
