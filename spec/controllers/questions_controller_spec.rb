require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  let(:question) { FactoryGirl.create :question }
  it '#index' do
    get :index
    expect(assigns(:questions)).to eq Question.all.order(vote: :desc)
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

  context '#edit' do
    before :each do
      @question = question
    end

    it 'should edit a question with valid params' do
      post :update, { id: @question.id, question: {title: "updated-title", content: "updated-content" } }
      @question.reload
      expect(@question.title).to eq("updated-title")
      expect(@question.content).to eq("updated-content")
    end

    it 'should edit a question with invalid params' do
      post :update, { id: @question.id, question: {content: "" } }
      @question.reload
      expect(@question.title).to eq("question title")
      expect(@question.content).to eq("question content")
    end
  end

  context 'Voting' do
    before :each do
      @question = question
    end

    it 'upvote should increase the vote count' do
      expect {
        patch :upvote, { id: @question.id }
        @question.reload
      }.to change { @question.vote }.by(1)
    end

    it 'downvote should increase the vote count' do
      expect {
        patch :downvote, { id: @question.id }
        @question.reload
      }.to change { @question.vote }.by(-1)
    end
  end
end
