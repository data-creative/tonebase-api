class UserFavoriteVideo < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates_associated :user
  validates_associated :video

  validates :user, {presence:true}
  validates :video, {presence:true, uniqueness: {scope: :user_id}}
end
