class VideosController < ApplicationController
  def show
    @video = Video.status_show.friendly.find params[:id]
    @commentable = @video
    @comments = @commentable.comments
    @comment = Comment.new
    @simlar_videos = @video.simlar_videos
  end

  def index      
    if params[:search]
      @videos = Video.status_show.search(params[:search])
            .order("created_at DESC").paginate page: params[:page], per_page: 7
    else
      @videos = Video.status_show.order("created_at DESC")
            .paginate page: params[:page], per_page: 7
    end
  end
end
