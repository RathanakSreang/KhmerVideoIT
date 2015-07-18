class ArticlesController < ApplicationController

  def show
    @article = Article.status_show.friendly.find params[:id]
    @article.show?
    @simlar_articles = @article.simlar_articles
    @commentable = @article
    @comments = @commentable.comments
    @comment = Comment.new    
  end

  def index
    if params[:search]
      @articles = Article.status_show.search(params[:search])
            .order("created_at DESC").paginate page: params[:page], per_page: 10
    else
      @articles = Article.status_show.order("created_at DESC")
            .paginate page: params[:page], per_page: 10
    end
  end
end
