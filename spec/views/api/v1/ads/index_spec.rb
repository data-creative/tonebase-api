require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/ads/index.json.jbuilder" do
  before(:each) do
    assign(:ads, [create(:ad), create(:ad)])
    render
  end

  it "displays ads, each with nested advertiser" do
    expect(parsed_response.count).to eql(2)
    parsed_response.each do |ad|
      expect(keys_of(ad)).to match_array([:id, :advertiser, :title, :content, :url, :image_url, :created_at, :updated_at])
    end
  end
end
