require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/instruments/index.json.jbuilder" do
  before(:each) do
    assign(:instruments, [create(:instrument), create(:instrument)])
    render
  end

  it "displays instruments" do
    expect(parsed_view.count).to eql(2)
    parsed_view.each do |instrument|
      expect(keys_of(instrument)).to match_array([:id, :name, :description, :created_at, :updated_at])
    end
  end
end
