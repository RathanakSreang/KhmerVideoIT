class TutorialsController < ApplicationController

  def show
    @tutorial = Tutorial.find params[:id]
    @videos = @tutorial.videos.paginate page: params[:page], per_page: 7
  end

  def index
    @tutorials = Tutorial.all.paginate page: params[:page], per_page: 10
  end
end
