class ArticlesController < ApplicationController

  def show
    @article = Article.find params[:id]
    @simlar_articles = @article.simlar_articles
    @commentable = @article
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def index
    if params[:search]
      @articles = Article.search(params[:search])
            .order("created_at DESC").paginate page: params[:page], per_page: 10
    else
      @articles = Article.order("created_at DESC")
            .paginate page: params[:page], per_page: 10
    end
  end
end
