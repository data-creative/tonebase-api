require 'rails_helper'

RSpec.describe Ad, type: :model do
  describe "associations" do
    it { should belong_to(:advertiser) }
  end

  describe "validations" do
    it { should validate_presence_of(:advertiser) }
    it { should validate_presence_of(:title) }
  end
end
