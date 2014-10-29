require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  let(:question) { FactoryGirl.create :question }
  it '#index' do
    get :index
    expect(assigns(:questions)).to eq Question.all
  end

  it '#show' do
    question = Question.create(title: "title", content: "content")
    get :show, id: question.id
    expect(assigns(:question)).to eq Question.find(question.id)
  end

  context '#new' do
    it 'should redirect to index' do
      get :new
      expect(response).to redirect_to(questions_path)
    end
  end

  context '#create' do
    it 'should create a question with valid params' do
      expect {
      post :create, { question: {title: "title", content: "content" } }
      }.to change { Question.count }.by(1)
    end

    it 'should create a question with invalid params' do
      expect {
      post :create, { question: {title: "", content: "" } }
      }.to change { Question.count }.by(0)
    end
  end

  context '#destroy' do
    it 'should delete a question' do
      question
      expect {
        post :destroy, { id: question.id }
      }.to change{ Question.count }.by(-1)
    end
  end
end
