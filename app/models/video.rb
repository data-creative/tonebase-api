class Video < ApplicationRecord
  belongs_to :user

  belongs_to :instrument

  has_many :user_favorite_videos, dependent: :destroy
  has_many :favorited_by_users, through: :user_favorite_videos, source: :user

  has_many :video_parts, dependent: :destroy, inverse_of: :video
  has_many :video_scores, dependent: :destroy, inverse_of: :video
  alias :parts :video_parts
  alias :scores :video_scores
  accepts_nested_attributes_for :video_parts
  accepts_nested_attributes_for :video_scores

  validates_associated :user
  validates_associated :instrument
  validates :user, {presence: true}
  validates :instrument, {presence: true}
  validates :title, {presence: true, uniqueness: {scope: :user_id}}
  validates :description, {presence: true}

  serialize(:tags, Array)
end
