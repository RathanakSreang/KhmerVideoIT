class SearchsController < ApplicationController

  def index    
    if params[:search].present?
      @videos = Video.search(params[:search]).order("created_at DESC")
      @articles = Article.search(params[:search]).order("created_at DESC")
      @questions = Question.search(params[:search]).order("created_at DESC")
    end
  end
end
