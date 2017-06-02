require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    #it { should validate_presence_of(:confirmed) } # doing this would not properly handle false values
    #it { should validate_presence_of(:visible) } # doing this would not properly handle false values
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:access_level) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    #it { should validate_inclusion_of(:confirmed).in_array([true, false]) } # Warning from shoulda-matchers: You are using `validate_inclusion_of` to assert that a boolean column allows boolean values and disallows non-boolean ones. Be aware that it is not possible to fully test this, as boolean columns will automatically convert non-boolean values to boolean ones. Hence, you should consider removing this test.
    #it { should validate_inclusion_of(:visible).in_array([true, false]) } # Warning from shoulda-matchers: You are using `validate_inclusion_of` to assert that a boolean column allows boolean values and disallows non-boolean ones. Be aware that it is not possible to fully test this, as boolean columns will automatically convert non-boolean values to boolean ones. Hence, you should consider removing this test.
    it { should validate_inclusion_of(:role).in_array(["User", "Artist", "Admin"]) }
    it { should validate_inclusion_of(:access_level).in_array(["Full", "Limited"]) }

    context "when requiring another model instance" do
      subject { build(:user) }
      it { should validate_uniqueness_of(:email) }
    end
  end
end
