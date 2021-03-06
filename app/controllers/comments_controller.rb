class CommentsController < ApplicationController
  before_action :authenticate_user!

  before_filter :load_commentable

  def index
    # @commentable = Video.find params[:video_id]
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new parent_id: params[:parent_id]
  end

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user_id = current_user.id
    if @comment.save
      track_activity @comment
    end
  end
  private

  def comment_params
    params.require(:comment).permit :id, :content, :parent_id
  end

  # def load_commentable
  #   locale, resource, id = request.path.split("/")[0, 1, 2]
  #   @commentable = resource.singularize.classify.constantize.find id
  # end

  def load_commentable
    klass = [Article, Video, Question].detect{|c| params["#{c.name.underscore}_id"]}
    @commentable = klass.friendly.find params["#{klass.name.underscore}_id"]
  end
end
