class UserFollowship < ApplicationRecord
  belongs_to :user
  belongs_to :followed_user, class_name: User

  validates_associated :user
  validates_associated :followed_user
  validates :user, {presence:true}
  validates :followed_user, {presence:true}
  validate :directional_uniqueness

private

  def duplicates
    UserFollowship.where(:user_id => user_id, :followed_user_id => followed_user_id)
  end

  def directional_uniqueness
    if duplicates.any?
      errors.add(:user_id, "is already following user #{followed_user_id}")
    end
  end
end
