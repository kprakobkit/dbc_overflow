class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    @question = Question.new
    @quote = Quote.get_quote
  end

  def new
    redirect_to questions_path
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to question_path(@question)
    else
      render 'index'
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def upvote
    @question = Question.find(params[:id])
    @question.vote += 1
    @question.save
    redirect_to questions_path
  end

  def downvote
    @question = Question.find(params[:id])
    @question.vote -= 1
    @question.save
    redirect_to questions_path
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
