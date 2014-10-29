require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  it '#index' do
    get :index
    expect(assigns(:questions)).to eq Question.all
  end

  it '#show' do
    question = Question.create(title: "title", content: "content")
    get :show, id: question.id
    expect(assigns(:question)).to eq Question.find(question.id)
  end
end
