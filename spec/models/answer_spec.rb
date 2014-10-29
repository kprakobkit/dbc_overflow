require 'rails_helper'

RSpec.describe Answer, :type => :model do
  describe "validates presence of title and content" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end
end
