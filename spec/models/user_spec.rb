require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:user_followships) }
    it { should have_many(:follows).through(:user_followships) }

    it { should have_many(:inverse_user_followships) }
    it { should have_many(:followers).through(:inverse_user_followships) }

    describe "self-referential user followships" do
      let(:user){ create(:user) }
      let(:artist){ create(:artist) }
      let!(:user_followhip) { create(:user_followship, user: user, followed_user: artist) }

      it "should associate user with follows" do
        expect(user.follows.first).to eql(artist)
        expect(artist.follows.any?).to eql(false)
      end

      it "should associate followed user with followers" do
        expect(artist.followers.first).to eql(user)
        expect(user.followers.any?).to eql(false)
      end
    end
  end

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

    describe "for uniqueness" do
      subject { build(:user) }
      it { should validate_uniqueness_of(:email) }
    end
  end

  describe "constants" do
    describe "ROLES" do
      it "returns a list of valid user roles" do
        expect(User::ROLES).to match_array(["User", "Artist", "Admin"])
      end
    end
  end

  describe "class methods" do
    describe "role-filtering methods" do
      let!(:users){ [create(:user), create(:user), create(:user), create(:artist), create(:artist), create(:admin)] }

      describe ".all" do
        it "does not filter users by role" do
          expect(User.all.count).to eql(users.count)
        end
      end

      describe ".users" do
        it "filters users by role" do
          expect(User.user.count).to eql(3)
        end
      end

      describe ".artist" do
        it "filters users by role" do
          expect(User.artist.count).to eql(2)
        end
      end

      describe ".admin" do
        it "filters users by role" do
          expect(User.admin.count).to eql(1)
        end
      end
    end
  end
end