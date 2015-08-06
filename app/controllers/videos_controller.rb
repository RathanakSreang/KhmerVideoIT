class VideosController < ApplicationController
  def show
    @video = Video.status_show.includes(:translations, :user, :tags => :translations)
                  .friendly.find(params[:id])            
    @commentable = @video
    @comments = @commentable.comments
    @comment = Comment.new
    @simlar_videos = @video.simlar_videos.includes(:translations, :tags => :translations)
  end

  def index      
    if params[:search]
      @videos = Video.status_show.search(params[:search])          
          .includes(:translations, :user, :tags => :translations)
          .paginate page: params[:page], per_page: 7
    else
      @videos = Video.status_show.order("created_at DESC")
            .includes(:translations, :user, :tags => :translations)
            .paginate page: params[:page], per_page: 7
    end
  end
end
