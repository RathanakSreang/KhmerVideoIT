class UsersController < ApplicationController  
  
  def show
    @user = User.find params[:id]
    @comments = @user.comments.order("created_at DESC")
                            .paginate page: params[:page], per_page: 7
  end

  def comment
    @user = User.find params[:id]
    @comments = @user.comments.order("created_at DESC")
                            .paginate page: params[:page], per_page: 7
  end

  def question
    @user = User.find params[:id]
    @questions = @user.questions.order("created_at DESC")
  end
end
