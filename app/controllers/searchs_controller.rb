class SearchsController < ApplicationController

  def index    
    if params[:search].present?
      @videos = Video.status_show.search(params[:search]).order("created_at DESC")
      @articles = Article.status_show.search(params[:search]).order("created_at DESC")
      @questions = Question.search(params[:search]).order("created_at DESC")
    end
  end
end
