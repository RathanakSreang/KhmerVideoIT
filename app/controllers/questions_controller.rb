class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_question, only: [:show, :edit, :update]

  def show
    @commentable = @question
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def index
    @questions = Question.order("created_at DESC").paginate page: params[:page],
                                                        per_page: 7
  end

  def new
    @question = current_user.questions.new
  end

  def create
    @question = current_user.questions.new question_params
    if @question.save
      flash[:success] = t "flash.success_create"
      redirect_to @question
    else
      flash.now[:danger] = t "flash.fail_create"
      render "new"
    end
  end

  def edit    
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "flash.success_update"
      redirect_to @question
    else
      flash.now[:danger] = t "flash.fail_update"
      render "edit"
    end
  end

  def destroy
    @question = Question.find params[:id]
    @question.destroy
  end

  private
  def load_question
    @question = Question.find params[:id]
  end

  def question_params
    params.require(:question).permit :id, :title, :content, tag_ids:[]
  end
end
