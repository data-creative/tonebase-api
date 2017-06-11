require 'rails_helper'

RSpec.describe Announcement, type: :model do
  describe "associations" do
    it { should have_many(:notifications) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }

    context "uniqueness" do
      subject { build(:announcement) }
      it { should validate_uniqueness_of(:title) }
    end
  end

  describe "call-backs" do
    describe "after_create " do
      describe "#broadcast_new_video_event_to_artist_followers" do
        let!(:users){ [create(:user), create(:user), create(:user)] }

        context "when the announcement is broadcastable" do
          let(:announcement){ create(:announcement, :with_callbacks, broadcast: true) }

          it "should create a new notification" do
            expect{ announcement }.to change{ Notification.count }.by(1)
          end

          it "should notify all users" do
            expect{ announcement }.to change{ UserNotification.count }.by(users.count)
          end
        end

        context "when the announcement is not broadcastable" do
          let(:announcement){ create(:announcement, :with_callbacks, broadcast: false) }

          it "should not create a new notification" do
            expect{ announcement }.to change{ Notification.count }.by(0)
          end

          it "should not notify users" do
            expect{ announcement }.to change{ UserNotification.count }.by(0)
          end
        end
      end
    end
  end
end
