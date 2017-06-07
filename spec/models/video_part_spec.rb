require 'rails_helper'

RSpec.describe VideoPart, type: :model do
  describe "associations" do
    it{ should belong_to(:video) }
  end

  describe "validations" do
    it{ should validate_presence_of(:video) }
    it{ should validate_presence_of(:source_url) }
    it{ should validate_presence_of(:number) }
    it{ should validate_presence_of(:duration) }

    it { should validate_numericality_of(:number).only_integer }
    it { should validate_numericality_of(:duration).only_integer }

    context "uniqueness" do
      subject { build(:video_part) }
      it { should validate_uniqueness_of(:number).scoped_to(:video_id) }
    end
  end
end
