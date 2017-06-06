require 'rails_helper'

RSpec.describe UserFavoriteVideo, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:video) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:video) }

    context "uniqueness" do
      subject { build(:user_favorite_video) }
      it { should validate_uniqueness_of(:video).scoped_to(:user_id) }
    end
  end
end
