require 'rails_helper'

RSpec.describe AdInstrument, type: :model do
  describe "associations" do
    it { should belong_to(:ad) }
    it { should belong_to(:instrument) }
  end

  describe "validations" do
    it { should validate_presence_of(:ad) }
    it { should validate_presence_of(:instrument) }
  end
end
