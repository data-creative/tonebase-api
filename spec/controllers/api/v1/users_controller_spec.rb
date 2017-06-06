require 'rails_helper'
require_relative '../../../support/api/v1/index'
require_relative '../../../support/api/v1/show'
require_relative '../../../support/api/v1/create'
require_relative '../../../support/api/v1/update'
require_relative '../../../support/api/v1/destroy'
require_relative '../../../support/api/v1/request'

RSpec.describe Api::V1::UsersController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "an index endpoint", User

    context "when a 'role' parameter is specified" do
      let!(:users){ [create(:user), create(:user), create(:artist), create(:admin)] }

      context "when role=User" do
        let(:response){  get(:index, params: {format: 'json', role: "User"})  }

        it "filters only those users matching the given role" do
          expect(parsed_response.count).to eql(User.user.count)
        end
      end

      context "when role=Artist" do
        let(:response){  get(:index, params: {format: 'json', role: "Artist"})  }

        it "includes only those users matching the given role" do
          expect(parsed_response.count).to eql(User.artist.count)
        end
      end

      context "when role=Admin" do
        let(:response){  get(:index, params: {format: 'json', role: "Admin"})  }

        it "includes only those users matching the given role" do
          expect(parsed_response.count).to eql(User.admin.count)
        end
      end

      context "when role is invalid" do
        let(:response){  get(:index, params: {format: 'json', role: "OOPS"})  }

        it "returns an error" do
          expect(response.code).to eql("404")
          expect(parsed_response["role"]).to include("not found")
        end
      end
    end
  end

  describe "GET #show" do
    it_behaves_like "a show endpoint", User
  end

  describe "POST #create" do
    it_behaves_like "a create endpoint", User do
      let(:resource_params){
        {
          email: "avg.joe@gmail.com",
          password: "abc123",
          confirmed: true,
          visible: true,
          role: "User",
          access_level: "Full",
          first_name: "Joe",
          last_name: "Averaggi",
          bio: "I love guitar and I'm hoping to get better!",
          image_url: "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg",
          hero_url: "https://my-bucket.s3.amazonaws.com/my-dir/hero-image.jpg",
          customer_uuid: "cus_abc123def45678",
          oauth: true,
          oauth_provider: "Google",
        }
      }
    end

    it_behaves_like "a create endpoint which validates presence", User, [:email, :password, :role, :access_level, :first_name, :last_name]

    it_behaves_like "a create endpoint which validates uniqueness", User, [:email] do
      let!(:other_user){ create(:user) }
      let(:resource_params){ {email: other_user.email} }
    end
  end

  describe "PUT #update" do
    it_behaves_like "an update endpoint", User, {bio: "My updated info."}
    it_behaves_like "an update endpoint which validates presence", User, [:email, :password, :role, :access_level, :first_name, :last_name]
    it_behaves_like "an update endpoint which validates uniqueness", User, :email
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", User
  end
end
