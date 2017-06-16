require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/user_view_videos/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:user_view_video), create(:user_view_video)])
    render
  end

  it_behaves_like "an index view", 2, [
    :id,
    :user_id,
    :video_id,
    :viewed_at
  ]
end
