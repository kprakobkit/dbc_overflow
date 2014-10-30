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

    respond_to do |format|
      if @question.save
        format.html {
          redirect_to question_path(@question), notice: 'Question was successfully saved'
        }
        format.js {}
      else
        format.html {
          render 'index'
        }
        format.js {}
      end
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
    respond_to do |format|
      format.html{
        redirect_to questions_path
      }
      format.js {}
    end
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
