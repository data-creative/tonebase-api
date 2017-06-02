require 'rails_helper'

RSpec.describe AdPlacement, type: :model do
  describe "associations" do
    it { should belong_to(:ad) }
  end

  describe "validations" do
    it { should validate_presence_of(:ad) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).only_integer }
    #TODO: validate non-overlapping dates between all placements of a given ad.
  end
end
