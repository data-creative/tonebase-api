require "rails_helper"
require_relative "../../../../support/api/v1/views/index"

describe "api/v1/users/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:user), create(:user)])
    render
  end

  it_behaves_like "an index view", 2, [
    :id,
    :email,
    :password,
    :username,
    :confirmed,
    :visible,
    :role,
    :access_level,
    :customer_uuid,
    :oauth,
    :oauth_provider,
    :profile,
    :music_profile,
    :follows,
    :followers,
    :favorite_videos,
    :recently_viewed_videos,
    :inbox,
    :created_at,
    :updated_at
  ]
end
