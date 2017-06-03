require 'rails_helper'

RSpec.describe UserFollowship, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:followed_user) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:followed_user) }
  end
end
