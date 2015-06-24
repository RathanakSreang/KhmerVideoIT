class VideosController < ApplicationController
  def show
    @video = Video.find params[:id]
  end

  def index
    @videos = Video.all.paginate page: params[:page], per_page: 10
  end
end
