require 'rails_helper'

RSpec.describe VideoScore, type: :model do
  describe "associations" do
    it{ should belong_to(:video) }
  end

  describe "validations" do
    it{ should validate_presence_of(:video) }
    it{ should validate_presence_of(:image_url) }
    it{ should validate_presence_of(:starts_at) }
    it{ should validate_presence_of(:ends_at) }

    it { should validate_numericality_of(:starts_at).only_integer }
    it { should validate_numericality_of(:ends_at).only_integer }
  end
end
