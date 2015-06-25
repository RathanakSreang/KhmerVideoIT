class StaticPagesController < ApplicationController
  def home
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
