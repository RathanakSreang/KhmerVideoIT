class VideosController < ApplicationController
  def show
    @video = Video.status_show.friendly.find(params[:id])
    @commentable = @video
    @comments = @commentable.comments
    @comment = Comment.new
    @simlar_videos = @video.simlar_videos
  end

  def index
    @videos = Video.status_show.order(publish_date: :desc).paginate page: params[:page], per_page: 7
  end
end
