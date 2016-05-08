require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "Comment associations and validations" do
    let(:comment) {build(:comment)}

    it { expect(comment).to validate_presence_of(:body) }
    it { expect(comment).to belong_to(:post) }
    it { expect(comment).to belong_to(:post) }
  end
end
