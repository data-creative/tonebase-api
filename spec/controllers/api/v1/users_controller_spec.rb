require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/endpoints/index'
require_relative '../../../support/api/v1/endpoints/show'
require_relative '../../../support/api/v1/endpoints/create'
require_relative '../../../support/api/v1/endpoints/update'
require_relative '../../../support/api/v1/endpoints/destroy'

RSpec.describe Api::V1::UsersController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "an index endpoint", User
    it_behaves_like "an index endpoint which paginates", User

    it_behaves_like "an index endpoint which searches", :role, "User", "OOPS" do
      let(:resources){ [create(:user), create(:user), create(:artist), create(:admin)] }
      let(:matching_resources){ User.user }
    end

    it_behaves_like "an index endpoint which searches", :role, "Artist", "OOPS" do
      let(:resources){ [create(:user), create(:user), create(:artist), create(:admin)] }
      let(:matching_resources){ User.artist }
    end

    it_behaves_like "an index endpoint which searches", :role, "Admin", "OOPS" do
      let(:resources){ [create(:user), create(:user), create(:artist), create(:admin)] }
      let(:matching_resources){ User.admin }
    end

    it_behaves_like "an index endpoint which searches", :email, "search4me@gmail.com", "OOPS" do
      let(:email){ "search4me@gmail.com" }
      let(:resources){ [create(:user), create(:user, email: email), create(:user)] }
      let(:matching_resources){ User.where(email: email) }
    end
  end

  describe "GET #show" do
    it_behaves_like "a show endpoint", User
  end

  describe "POST #create" do
    context "with valid params" do
      context "with both profiles" do
        it_behaves_like "a create endpoint", User do
          let(:also_serialize){ [:user_profile_attributes, :user_music_profile_attributes] }
          let(:resource_params){
            {
              email: "avg.joe@gmail.com",
              password: "abc123",
              username: "joe123",
              confirmed: true,
              visible: true,
              role: "User",
              access_level: "Full",
              customer_uuid: "cus_abc123def45678",
              oauth: true,
              oauth_provider: "Google",
              user_profile_attributes:{
                first_name: "Joe",
                last_name: "Averaggi",
                bio: "I love guitar and I'm hoping to get better!",
                image_url: "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg",
                hero_url: "https://my-bucket.s3.amazonaws.com/my-dir/hero-image.jpg",
                birth_year: 1975,
                professions: ["Student", "Performer", "Instructor"]
              },
              user_music_profile_attributes: {
                guitar_owned: true,
                guitar_models_owned: ["Gibson ABC", "Fender XYZ"],
                fav_composers: ["Bach"],
                fav_performers: ["Talenti"],
                fav_periods: ["Classical", "Contemporary", "Baroque"]
              }
            }
          }
        end
      end

      context "with only a user profile" do
        it_behaves_like "a create endpoint", User do
          let(:also_serialize){ [:user_profile_attributes] }
          let(:resource_params){
            {
              email: "avg.joe@gmail.com",
              password: "abc123",
              username: "joe123",
              confirmed: true,
              visible: true,
              role: "User",
              access_level: "Full",
              customer_uuid: "cus_abc123def45678",
              oauth: true,
              oauth_provider: "Google",
              user_profile_attributes:{
                first_name: "Joe",
                last_name: "Averaggi",
                bio: "",
                image_url: "",
                hero_url: "",
                birth_year: nil,
                professions: []
              },
            }
          }
        end
      end

      context "without any profiles" do
        it_behaves_like "a create endpoint", User do
          let(:resource_params){
            {
              email: "avg.joe@gmail.com",
              password: "abc123",
              username: "joe123",
              confirmed: true,
              visible: true,
              role: "User",
              access_level: "Full",
              customer_uuid: "cus_abc123def45678",
              oauth: true,
              oauth_provider: "Google"
            }
          }
        end
      end
    end

    it_behaves_like "a create endpoint which validates presence", User, [:email, :password, :role, :access_level, "user_profile.first_name", "user_profile.last_name"] do
      let(:resource_params){
        {
          email: "",
          password: "",
          username: "",
          role: "",
          access_level: "",
          user_profile_attributes:{first_name: nil, last_name: nil}
        }
      }
     end

    it_behaves_like "a create endpoint which validates uniqueness", User, [:email, :username] do
      let!(:other_user){ create(:user) }
      let(:resource_params){ {email: other_user.email, username: other_user.username} }
    end
  end

  describe "PUT #update" do
    it_behaves_like "an update endpoint", User, {email: "new.email@example.com"}

    it_behaves_like "an update endpoint which validates presence", User, [:email, :password, :role, :access_level, "user_profile.first_name", "user_profile.last_name"] do
      let(:resource_params){
        {
          email: "",
          password: "",
          username: "",
          role: "",
          access_level: "",
          user_profile_attributes:{first_name: nil, last_name: nil}
        }
      }
    end

    it_behaves_like "an update endpoint which validates uniqueness", User, [:email, :username]  do
      let!(:other_user){ create(:user)}
      let(:resource_params){ {email: other_user.email, username: other_user.username} }
    end
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", User
  end
end
