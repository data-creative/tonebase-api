require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/videos/show.json.jbuilder" do
  before(:each) do
    assign(:video, create(:video) )
    render
  end

  it "displays a video" do
    expect(keys_of(parsed_view)).to match_array([
      :id,
      :artist,
      :instrument,
      :title, :description, :tags,
      :parts,
      :scores,
      :favorited_by,
      :recently_viewed_by,
      :created_at, :updated_at
    ])
  end
end
