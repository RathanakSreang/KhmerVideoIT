class TagsController < ApplicationController

  def show
    @tag = Tag.find params[:id]
    @videos = @tag.videos.order("created_at DESC")                          
    @articles = @tag.articles.order("created_at DESC")
  end
end
