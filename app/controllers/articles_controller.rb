class ArticlesController < ApplicationController

  def show
    @article = Article.find params[:id]
    @simlar_articles = Article.order("RAND()").limit(4)
    @commentable = @article
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def index
    @articles = Article.all.paginate page: params[:page], per_page: 10
  end
end
