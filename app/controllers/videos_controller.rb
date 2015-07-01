class VideosController < ApplicationController
  def show
    @video = Video.find params[:id]
    @commentable = @video
    @comments = @commentable.comments
    @comment = Comment.new
    @simlar_videos = @video.simlar_videos
  end

  def index      
      @videos = Video.order("created_at DESC").paginate page: params[:page],
                                                        per_page: 7    
  end
end
