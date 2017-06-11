require 'rails_helper'

RSpec.describe Broadcast do
  describe "#perform" do
    let(:artist){ create(:artist, :with_followers)}
    let(:video){ create(:video, user: artist)}
    let(:broadcast){
      Broadcast.new({
        broadcastable: video,
        event: "NewVideo",
        headline: "#{artist.name} posted a new video. Watch it now!",
        users: artist.followers
      })
    }

    it "should create a notification" do
      expect{ broadcast.perform }.to change{ Notification.count }.by(1)
    end

    it "should notify the specified users" do
      expect{ broadcast.perform }.to change{ UserNotification.count }.by(broadcast.users.count)
    end
  end
end
