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
    search = Video.search do
      fulltext params[:search]
      with :status, true
      order_by :publish_date, :desc
      paginate page: params[:page], per_page: 7
    end
    @videos = search.results
  end
end
