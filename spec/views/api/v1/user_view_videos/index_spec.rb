require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/user_view_videos/index.json.jbuilder" do
  before(:each) do
    assign(:user_view_videos, [create(:user_view_video), create(:user_view_video)])
    render
  end

  it "displays advertisers" do
    expect(parsed_view.count).to eql(2)
    parsed_view.each do |resource|
      expect(keys_of(resource)).to match_array([:user_id, :video_id, :viewed_at])
    end
  end
end
