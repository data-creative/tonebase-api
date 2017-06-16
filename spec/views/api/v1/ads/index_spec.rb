require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/ads/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:ad), create(:ad)])
    render
  end

  it "displays ads, each with nested advertiser" do
    expect(parsed_view.count).to eql(2)
    parsed_view.each do |ad|
      expect(keys_of(ad)).to match_array([:id, :advertiser, :title, :content, :url, :image_url, :instruments, :created_at, :updated_at])
    end
  end
end
