require 'rails_helper'

RSpec.describe Instrument, type: :model do
  describe "associations" do
    it { should have_many(:ad_instruments) }
    it { should have_many(:ads).through(:ad_instruments) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }

    context "when requiring another model instance" do
      subject { build(:instrument) }
      it { should validate_uniqueness_of(:name) }
    end
  end
end
