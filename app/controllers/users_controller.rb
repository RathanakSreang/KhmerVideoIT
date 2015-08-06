class UsersController < ApplicationController  
  
  def show
    @user = User.friendly.find params[:id]
    @comments = @user.comments
                     .order("created_at DESC")
                     .includes(:commentable)
                     .paginate page: params[:page], per_page: 7
  end

  def comment
    @user = User.friendly.find params[:id]
    @comments = @user.comments.order("created_at DESC")
                            .paginate page: params[:page], per_page: 7
  end

  def question
    @user = User.friendly.find params[:id]
    @questions = @user.questions.order("created_at DESC")
  end
end
