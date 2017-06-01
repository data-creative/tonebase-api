require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/advertisers/index.json.jbuilder" do
  before(:each) do
    assign(:advertisers, [create(:advertiser), create(:advertiser)])
    render
  end

  it "displays advertisers" do
    expect(parsed_view.count).to eql(2)
    parsed_view.each do |advertiser|
      expect(keys_of(advertiser)).to match_array([:id, :name, :description, :url, :created_at, :updated_at])
    end
  end
end
