require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/videos/index.json.jbuilder" do
  before(:each) do
    assign(:videos, [create(:video), create(:video)])
    render
  end

  it "displays videos" do
    expect(parsed_view.count).to eql(2)
    parsed_view.each do |video|
      expect(keys_of(video)).to match_array([
        :id,
        :artist,
        :instrument,
        :title, :description, :tags,
        :favorited_by,
        :created_at, :updated_at
      ])
    end
  end
end
