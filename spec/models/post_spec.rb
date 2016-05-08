require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Post associations and validations" do
    let(:post) {build(:post)}

    it { expect(post).to validate_presence_of(:title) }
    it { expect(post).to validate_presence_of(:body) }
    it { expect(post).to belong_to(:user) }
    it { expect(post).to have_many(:comments).dependent(:destroy) }
  end
end
