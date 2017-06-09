require 'rails_helper'

RSpec.describe UserNotification, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:notification) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:notification) }

    # there is a problem generating more than one :notification factory due to a uniqueness constraint that is not being sequenced properly.
    # https://stackoverflow.com/questions/44467135/factory-girl-how-to-sequence-an-association
    #context "uniqueness" do
    #  subject { build(:user_notification) }
    #  it { should validate_uniqueness_of(:notification).scoped_to(:user_id) }
    #end
  end
end
