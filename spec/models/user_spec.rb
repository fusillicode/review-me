require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User associations and validations" do
    let(:user) {build(:user)}

    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to have_many(:posts) }
  end
end
