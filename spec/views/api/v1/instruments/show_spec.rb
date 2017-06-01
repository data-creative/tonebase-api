require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/instruments/show.json.jbuilder" do
  before(:each) do
    assign(:instrument, create(:instrument) )
    render
  end

  it "displays an advertiser" do
    expect(keys_of(parsed_view)).to match_array([:id, :name, :description, :created_at, :updated_at])
  end
end
