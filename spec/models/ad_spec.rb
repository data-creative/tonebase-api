require 'rails_helper'

RSpec.describe Ad, type: :model do
  describe "associations" do
    it { should belong_to(:advertiser) }
    it { should have_many(:ad_placements) }
    it { should have_many(:ad_instruments) }
    it { should have_many(:instruments).through(:ad_instruments) }
  end

  describe "validations" do
    it { should validate_presence_of(:advertiser) }
    it { should validate_presence_of(:title) }
  end
end
