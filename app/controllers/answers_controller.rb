class AnswersController < ApplicationController
  def new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to question_path(@question)
    else
      render 'questions/show'
    end
  end

  def upvote
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
    @answer.vote += 1
    @answer.save
    redirect_to question_path(@question)
  end

  def downvote
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
    @answer.vote -= 1
    @answer.save
    redirect_to question_path(@question)
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :content)
  end
end
