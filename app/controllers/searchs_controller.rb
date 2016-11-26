class SearchsController < ApplicationController

  def index
    @videos = Video.order(publish_date: :desc).paginate page: params[:page], per_page: 7
    @articles = Article.order(publish_date: :desc).paginate page: params[:page], per_page: 7
  end
end
