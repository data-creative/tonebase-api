class Video < ApplicationRecord
  belongs_to :user
  belongs_to :instrument
  has_many :user_favorite_videos
  has_many :favorited_by_users, :through => :user_favorite_videos, :source => :user

  validates_associated :user
  validates_associated :instrument
  validates :user, {presence: true}
  validates :instrument, {presence: true}
  validates :title, {presence: true, uniqueness: {scope: :user_id}}
  validates :description, {presence: true}

  serialize(:tags, Array)
end
