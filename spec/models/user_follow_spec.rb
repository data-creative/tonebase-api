require 'rails_helper'

RSpec.describe UserFollow, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:follower) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:follower) }

    describe "for uniqueness" do
      subject { build(:user_follow) }
      it { should validate_uniqueness_of(:follower).scoped_to(:user_id).with_message("is already following this user") } # user_id _id suffix is a work-around for association scope issue: https://github.com/thoughtbot/shoulda-matchers/issues/814
    end
  end
end
