class AnswersController < ApplicationController
  def new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html {
          redirect_to question_path(@question)
        }
        format.js {}
      else
        format.html {
          render 'questions/show'
        }
        format.js {}
      end
    end
  end

  def upvote
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
    @answer.vote += 1
    @answer.save
    respond_to do |format|
      format.html{
        redirect_to question_path(@question)
      }
      format.js {}
    end
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
