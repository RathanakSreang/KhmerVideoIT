class StaticPagesController < ApplicationController
  def home
    @videos = Video.order_video.limit(5)
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
