require 'rails_helper'

RSpec.describe UserNotification, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:notification) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:notification) }

    context "uniqueness" do
      subject { build(:user_notification) }
      it { should validate_uniqueness_of(:notification).scoped_to(:user_id) }
    end
  end
end
