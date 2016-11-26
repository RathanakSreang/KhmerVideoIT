class ArticlesController < ApplicationController

  def show
    @article = Article.status_show.friendly.find params[:id]
    # @article.show?
    @simlar_articles = @article.simlar_articles
    @commentable = @article
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def index
    @articles = Article.status_show.order(publish_date: :desc).paginate page: params[:page], per_page: 7
  end
end
