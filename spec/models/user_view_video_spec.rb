require 'rails_helper'

RSpec.describe UserViewVideo, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:video) }
  end

  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:video) }
  end
end
