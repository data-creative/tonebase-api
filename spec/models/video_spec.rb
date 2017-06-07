require 'rails_helper'

RSpec.describe Video, type: :model do
  it { should serialize(:tags).as(Array) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:instrument) }

    it { should have_many(:user_favorite_videos).dependent(:destroy) }
    it { should have_many(:favorited_by_users).through(:user_favorite_videos) }

    it { should have_many(:video_parts).dependent(:destroy) }
    it { should have_many(:video_scores).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:instrument) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }

    context "uniqueness" do
      subject { build(:video) }
      it { should validate_uniqueness_of(:title).scoped_to(:user_id) }
    end
  end
end
