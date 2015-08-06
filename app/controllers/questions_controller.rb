class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_question, only: [:show, :edit, :update]

  def show
    @commentable = @question
    @comments = @commentable.comments
    @comment = Comment.new
    @simlar_questions = @question.simlar_questions.includes(:user, :tags => :translations)
  end

  def index    
    if params[:search]
      @questions = Question.search(params[:search])            
            .includes(:user, :tags => :translations)
            .paginate page: params[:page], per_page: 7
    else
      @questions = Question.order("created_at DESC")
            .includes(:user, :tags => :translations)
            .paginate page: params[:page], per_page: 7
    end
  end

  def new
    @question = current_user.questions.new
  end

  def create
    @question = current_user.questions.new question_params
    if @question.save
      flash[:success] = t "flash.success_create"
      track_activity @question
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
      track_activity @question
      redirect_to @question
    else
      flash.now[:danger] = t "flash.fail_update"
      render "edit"
    end
  end

  def destroy
    @question = Question.friendly.find params[:id]
    track_activity @question
    @question.destroy
    flash[:success] = t "flash.success_delete"
    redirect_to questions_path
  end

  private
  def load_question
    @question = Question.includes(:user, :tags => :translations).friendly.find(params[:id])
  end

  def question_params
    params.require(:question).permit :id, :title, :content, tag_ids:[]
  end
end
