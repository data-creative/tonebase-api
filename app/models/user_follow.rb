class UserFollow < ApplicationRecord
  belongs_to :user
  belongs_to :follower, :class_name => User, :foreign_key => "follower_id"

  validates_associated :user
  validates_associated :follower
  validates :user, {presence:true}
  validates :follower, { # user_id _id suffix is a work-around for association scope issue: https://github.com/thoughtbot/shoulda-matchers/issues/814
    presence:true,
    uniqueness: { scope: :user_id, message: "is already following this user" }
  }
end
