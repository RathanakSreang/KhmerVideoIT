class ArticlesController < ApplicationController

  def show
    @article = Article.status_show
                      .includes(:translations, :user, :tags => :translations)
                      .friendly.find params[:id]
    # @article.show?
    @simlar_articles = @article.simlar_articles
                      .includes(:translations, :user, :tags => :translations)
    @commentable = @article
    @comments = @commentable.comments
    @comment = Comment.new    
  end

  def index
    search = Article.search do
      fulltext params[:search]
      with :status, true
      order_by :publish_date, :desc
      paginate page: params[:page], per_page: 7
    end
    @articles = search.results
  end
end
