require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/announcements/index.json.jbuilder" do
  before(:each) do
    assign(:announcements, [create(:announcement), create(:announcement)])
    render
  end

  it "displays announcements" do
    expect(parsed_view.count).to eql(2)
    parsed_view.each do |announcement|
      expect(keys_of(announcement)).to match_array([:id, :title, :content, :url, :image_url, :created_at, :updated_at])
    end
  end
end
