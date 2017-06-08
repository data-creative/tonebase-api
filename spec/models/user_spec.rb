require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_one(:user_profile).dependent(:destroy) }
    it { should have_one(:user_music_profile).dependent(:destroy) }

    it { should accept_nested_attributes_for(:user_profile) }
    it { should accept_nested_attributes_for(:user_music_profile) }

    it { should have_many(:user_followships).dependent(:destroy) }
    it { should have_many(:follows).through(:user_followships) }
    it { should have_many(:inverse_user_followships).dependent(:destroy) }
    it { should have_many(:followers).through(:inverse_user_followships) }

    it { should have_many(:videos).dependent(:destroy) }

    it { should have_many(:user_favorite_videos).dependent(:destroy) }
    it { should have_many(:favorite_videos).through(:user_favorite_videos) }

    it { should have_many(:user_view_videos).dependent(:destroy) }
    it { should have_many(:viewed_videos).through(:user_view_videos) }

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
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:access_level) }

    it { should validate_inclusion_of(:role).in_array(["User", "Artist", "Admin"]) }
    it { should validate_inclusion_of(:access_level).in_array(["Full", "Limited"]) }

    describe "email uniqueness" do
      subject { build(:user) }
      it { should validate_uniqueness_of(:email) }
    end

    describe "username uniqueness" do
      subject { build(:user) }
      it { should validate_uniqueness_of(:username) }
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

  describe "instance methods" do
    describe "#recent_video_views" do
      let(:user){ create(:user) }
      let(:video){ create(:video, title: "First") }
      let(:other_video){ create(:video, title: "Second") }
      let(:third_video){ create(:video, title: "Third") }

      describe "limits results" do
        let(:fourth_video){ create(:video, title: "Fourth") }
        let(:fifth_video){ create(:video, title: "Fifth") }

        let!(:first_view){ create(:user_view_video, user: user, video: video)}
        let!(:second_view){ create(:user_view_video, user: user, video: other_video)}
        let!(:third_view){ create(:user_view_video, user: user, video: third_video)}
        let!(:fourth_view){ create(:user_view_video, user: user, video: fourth_video)}
        let!(:fifth_view){ create(:user_view_video, user: user, video: fifth_video)}

        it "should return a list of recent video views" do
          video_ids = user.recent_video_views(3).to_a.map{|view| view.video_id}
          expect(video_ids).to eql([fifth_view.video_id, fourth_view.video_id, third_view.video_id])
        end
      end

      describe "groups results by unique video" do
        let!(:first_view){ create(:user_view_video, user: user, video: video)}
        let!(:second_view){ create(:user_view_video, user: user, video: other_video)}
        let!(:third_view){ create(:user_view_video, user: user, video: third_video)}
        let!(:fourth_view){ create(:user_view_video, user: user, video: other_video)}
        let!(:fifth_view){ create(:user_view_video, user: user, video: third_video)}

        it "should include only the user's most recent view for any given video" do
          video_ids = user.recent_video_views(3).to_a.map{|view| view.video_id}
          expect(video_ids).to eql([fifth_view.video_id, fourth_view.video_id, first_view.video_id])
        end
      end
    end
  end
end
