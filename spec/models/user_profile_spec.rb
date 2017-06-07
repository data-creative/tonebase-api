require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  it { should serialize(:professions).as(Array) }

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it { should validate_numericality_of(:birth_year).only_integer }
    it { should validate_numericality_of(:birth_year).allow_nil }

    context "uniqueness" do
      subject { build(:user_profile) }
      it { should validate_uniqueness_of(:user) }
    end
  end
end
