class Admin::VideosController < ApplicationController
  layout "admin/application"

  def show
    @video = Video.find params[:id]
  end

  def index
    @videos = Video.all.paginate page: params[:page], per_page: 10
  end

  def new
    @video = Video.new
    @video.build_article
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
    params.require(:video).permit :id, :tutorial_id, :title, :image, :image_cache, :description,
                                  :link, :file, :duration,
                                  usefull_links_attributes: [:id, :title, :link, :_destroy],
                                  article_attributes: [:id, :content]

  end
end
