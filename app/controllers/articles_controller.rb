class ArticlesController < ApplicationController

  def show
    @article = Article.find params[:id]
    @simlar_articles = @article.language.articles.order("RAND()").limit(4)
  end

  def index
    @articles = Article.all.paginate page: params[:page], per_page: 10
  end
end
