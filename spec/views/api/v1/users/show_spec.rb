require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/users/show.json.jbuilder" do
  before(:each) do
    assign(:user, create(:user) )
    render
  end

  it "displays a user" do
    expect(keys_of(parsed_view)).to match_array([
      :id, :email, :password, :username, :confirmed, :visible, :role, :access_level,
      :customer_uuid,
      :oauth, :oauth_provider,
      :profile, :music_profile,
      :follows, :followers,
      :favorite_videos,
      :recently_viewed_videos,
      :created_at, :updated_at
    ])
  end
end
