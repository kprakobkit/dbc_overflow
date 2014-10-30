require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  let(:question) { FactoryGirl.create :question }
  let(:answer) { FactoryGirl.create :answer }

  context '#create' do
    it 'should create an answer with valid params' do
      expect {
        post :create, { question_id: question.id, answer: { title: "title", content: "content"} }
      }.to change { Answer.count }.by(1)
    end

    it 'should not create an answer with invalid params' do
      expect {
        post :create, { question_id: question.id, answer: { title: "", content: "content"} }
      }.to change { Answer.count }.by(0)
    end
  end

  context 'Voting' do
    before :each do
      @question = question
      @answer = answer
    end

    it 'upvote should increase the vote count' do
      expect {
        patch :upvote, { question_id: @question.id, id: @answer.id }
        @answer.reload
      }.to change { @answer.vote }.by(1)
    end

    it 'downvote should increase the vote count' do
      expect {
        patch :downvote, { question_id: @question.id, id: @answer.id }
        @answer.reload
      }.to change { @answer.vote }.by(-1)
    end
  end
end
