require 'rails_helper'

RSpec.describe Video, type: :model do
  it { should serialize(:tags).as(Array) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:instrument) }
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
