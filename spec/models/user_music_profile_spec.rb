require 'rails_helper'

RSpec.describe UserMusicProfile, type: :model do
  it { should serialize(:guitar_models_owned).as(Array) }
  it { should serialize(:fav_composers).as(Array) }
  it { should serialize(:fav_performers).as(Array) }
  it { should serialize(:fav_periods).as(Array) }

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }

    context "uniqueness" do
      subject { build(:user_music_profile) }
      it { should validate_uniqueness_of(:user) }
    end
  end
end
