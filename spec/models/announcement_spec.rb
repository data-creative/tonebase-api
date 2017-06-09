require 'rails_helper'

RSpec.describe Announcement, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }

    context "uniqueness" do
      subject { build(:announcement) }
      it { should validate_uniqueness_of(:title) }
    end
  end
end
