class StaticPagesController < ApplicationController
  def home
    @videos = Video.status_show.order_video
                    .includes(:translations, :user, :tags => :translations)
                    .limit(3)
    @articles = Article.status_show.order("created_at DESC")
                        .includes(:translations, :user, :tags => :translations)
                        .limit(3)
    @questions = Question.order("created_at DESC")
                        .includes(:user, :tags => :translations)
                        .limit(3)
  end

  def privacy
  end

  def about
    @page = Page.first
    @users = User.all_admin.order(:created_at)
    @page = Page.new unless @page
  end

  def contact
  end
end
