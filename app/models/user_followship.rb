class UserFollowship < ApplicationRecord
  belongs_to :user
  belongs_to :followed_user, class_name: User

  validates_associated :user
  validates_associated :followed_user
  validates :user, {presence:true}
  validates :followed_user, {presence:true}
end
