require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/user_view_videos/show.json.jbuilder" do
  before(:each) do
    assign(:user_view_video, create(:user_view_video) )
    render
  end

  it "displays a resource" do
    expect(keys_of(parsed_view)).to match_array([:user_id, :video_id, :viewed_at])
  end
end
