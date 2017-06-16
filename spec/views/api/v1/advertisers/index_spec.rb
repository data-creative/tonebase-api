require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/advertisers/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:advertiser), create(:advertiser)])
    render
  end

  it_behaves_like "an index view", 2, [
    :id,
    :name,
    :description,
    :url,
    :created_at,
    :updated_at
  ]
end
