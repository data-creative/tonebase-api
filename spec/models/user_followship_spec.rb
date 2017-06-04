require 'rails_helper'

RSpec.describe UserFollowship, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:followed_user) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:followed_user) }

    describe "uniqueness" do
      describe ".directional_uniqueness" do
        context "when a one user is following another" do
          let(:user){ create(:user) }
          let(:followed_user){ create(:followed_user) }
          let!(:user_followship){ create(:user_followship, :user => user, followed_user: followed_user) }

          let(:duplicate_followship){ create(:user_followship, :user => user, followed_user: followed_user) }
          let(:inverse_followship){ create(:user_followship, :user => followed_user, followed_user: user) }

          it "should not allow the same user to follow the same other" do
            expect{ duplicate_followship }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: User is already following user #{followed_user.id}")
          end

          it "should still allow the other user to follow the original user" do
            expect{ inverse_followship }.to change{ UserFollowship.count }.by(1)
          end
        end
      end
    end
  end
end
