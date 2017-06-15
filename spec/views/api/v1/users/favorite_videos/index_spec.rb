require "rails_helper"
require_relative "../../../../../support/api/v1/view"

describe "api/v1/users/favorite_videos/index.json.jbuilder" do
  before(:each) do
    assign(:user_favorite_videos, [create(:user_favorite_video), create(:user_favorite_video)])
    render
  end

  it "displays favorite videos" do
    expect(parsed_view.count).to eql(2)
    parsed_view.each do |resource|
      expect(keys_of(resource)).to match_array([
        :favorite_video,
        :favorited_at,
      ])
    end
  end
end
