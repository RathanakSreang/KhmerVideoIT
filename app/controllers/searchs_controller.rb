class SearchsController < ApplicationController

  def index    
    if params[:search].present?
      @videos = Video.status_show.search(params[:search])                
                .includes(:translations, :user, :tags => :translations)
      @articles = Article.status_show.search(params[:search])                
                .includes(:translations, :user, :tags => :translations)
      @questions = Question.search(params[:search])                
                .includes(:user, :tags => :translations)
    end
  end
end
