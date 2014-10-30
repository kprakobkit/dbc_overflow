require 'rails_helper'

describe 'User browsing the website' do
  before :each do
    question = Question.create(title: "title", content: "content")
    answer = question.answers.create(title: "title-answer", content: "content-answer")
  end

  context "on homepage" do
    it "sees a list of questions" do
      visit root_path
      expect(page).to have_content("DBC Overflow")
    end

    it "can click on the show link of each question and should be on the question show page" do
      visit root_path
      first(:link, 'Show').click
      expect(page).to have_content "title"
    end
  end

  context "question show page" do
    it "sees title and body of the post" do
      visit root_path
      first(:link, 'Show').click
      expect(page).to have_content "title"
      expect(page).to have_content "title-answer"
      expect(page).to have_content "content-answer"
    end
  end
end
