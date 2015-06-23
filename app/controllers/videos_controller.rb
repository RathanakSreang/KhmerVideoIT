class VideosController < ApplicationController
  def show
    
  end

  def index
    @videos = Video.all
  end
end
