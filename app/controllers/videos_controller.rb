class VideosController < ApplicationController
  def show
    @video = Video.find params[:id]
    @simlar_videos = @video.tutorial.language.videos.order("RAND()").limit(4)
  end

  def index    
    if params[:search]
      @videos = Video.search(params[:search]).order("created_at DESC").paginate page: params[:page], per_page: 7
    else
      @videos = Video.order("created_at DESC").paginate page: params[:page], per_page: 7
    end
  end
end
