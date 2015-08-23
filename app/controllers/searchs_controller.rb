class SearchsController < ApplicationController

  def index
    search = Video.search do
      fulltext params[:search]
      with :status, true
      order_by :publish_date, :desc
      paginate page: params[:page], per_page: 7
    end
    @videos = search.results
    search = Article.search do
      fulltext params[:search]
      with :status, true
      order_by :publish_date, :desc
      paginate page: params[:page], per_page: 7
    end
    @articles = search.results
    search = Question.search do
      fulltext params[:search]
      order_by :created_at, :desc
      paginate page: params[:page], per_page: 7
    end
    @questions = search.results
  end
end
