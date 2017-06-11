require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "associations" do
    it { should belong_to(:broadcastable) }

    it { should have_many(:user_notifications).dependent(:destroy) }
    it { should have_many(:users).through(:user_notifications) }
  end

  describe "validations" do
    it { should validate_presence_of(:broadcastable) }
    it { should validate_presence_of(:event) }
    it { should validate_presence_of(:headline) }

    it { should validate_inclusion_of(:event).in_array(["NewVideo"]) }

    # Known issues preventing this test from passing:
    #  https://github.com/thoughtbot/shoulda-matchers/issues/814
    #  https://github.com/thoughtbot/shoulda-matchers/issues/830
    #
    #context "uniqueness" do
    #  subject { build(:notification) }
    #  it { should validate_uniqueness_of(:event).scoped_to(:broadcastable_type, :broadcastable_id) }
    #end
  end
end
