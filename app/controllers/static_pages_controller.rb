class StaticPagesController < ApplicationController
  def home
    @videos = Video.status_show.order_video.limit(3)
    @articles = Article.status_show.order("created_at DESC").limit(3)
    @questions = Question.order("created_at DESC").limit(3)
  end

  def help
  end

  def about
    @page = Page.first
    @page = Page.new unless @page
  end

  def contact
  end
end
