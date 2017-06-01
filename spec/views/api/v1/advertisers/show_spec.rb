require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/advertisers/show.json.jbuilder" do
  before(:each) do
    assign(:advertiser, create(:advertiser) )
    render
  end

  it "displays an advertiser" do
    expect(keys_of(parsed_view)).to match_array([:id, :name, :description, :url, :created_at, :updated_at])
  end
end
