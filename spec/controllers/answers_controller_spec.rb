require 'rails_helper'

RSpec.describe AnswersController, :type => :controller do
  let(:question) { FactoryGirl.create :question }

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

end
