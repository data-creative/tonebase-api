require "rails_helper"
require_relative "../../../../support/api/v1/views/index"

describe "api/v1/instruments/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:instrument), create(:instrument)])
    render
  end

  it_behaves_like "an index view", 2, [
    :id,
    :name,
    :description,
    :created_at,
    :updated_at
  ]
end
