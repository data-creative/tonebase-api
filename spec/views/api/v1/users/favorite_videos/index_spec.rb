require "rails_helper"
require_relative "../../../../../support/api/v1/views/index"

describe "api/v1/users/favorite_videos/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:user_favorite_video), create(:user_favorite_video)])
    render
  end

  it_behaves_like "an index view", 2, [
    :id,
    :favorite_video,
    :favorited_at,
  ]
end
