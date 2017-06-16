require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/users/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:user), create(:user)])
    render
  end

  it "displays resources" do
    expect(parsed_view.count).to eql(2)
    parsed_view.each do |user|
      expect(keys_of(user)).to match_array([
        :id, :email, :password, :username, :confirmed, :visible, :role, :access_level,
        :customer_uuid,
        :oauth, :oauth_provider,
        :profile, :music_profile,
        :follows, :followers,
        :favorite_videos,
        :recently_viewed_videos,
        :inbox,
        :created_at, :updated_at
      ])
    end
  end
end
