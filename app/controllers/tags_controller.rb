class TagsController < ApplicationController

  def show
    @tag = Tag.friendly.find params[:id]
    @videos = @tag.videos.order("created_at DESC")
                  .paginate page: params[:page], per_page: 5
    @articles = @tag.articles.order("created_at DESC")
                    .paginate page: params[:page], per_page: 5
    @questions = @tag.questions.order("created_at DESC")
                    .paginate page: params[:page], per_page: 5
  end
end
