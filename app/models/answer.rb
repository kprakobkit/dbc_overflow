class Answer < ActiveRecord::Base
  validates_presence_of :title, :content

  belongs_to :question
end
