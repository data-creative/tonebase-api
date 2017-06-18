class Video < ApplicationRecord
  searchkick text_middle: [:title]

  after_create :broadcast_new_video_event_to_artist_followers

  #
  # ASSOCIATIONS
  #

  belongs_to :user

  belongs_to :instrument

  has_many :video_parts, dependent: :destroy, inverse_of: :video
  has_many :video_scores, dependent: :destroy, inverse_of: :video
  alias :parts :video_parts
  alias :scores :video_scores
  accepts_nested_attributes_for :video_parts
  accepts_nested_attributes_for :video_scores

  has_many :user_favorite_videos, dependent: :destroy
  has_many :favorited_by_users, through: :user_favorite_videos, source: :user

  has_many :user_view_videos, dependent: :destroy
  alias :views :user_view_videos
  has_many :viewed_by_users, -> { distinct }, through: :user_view_videos, source: :user

  has_many :notifications, as: :broadcastable, dependent: :destroy

  #
  # VALIDATIONS
  #

  validates_associated :user
  validates_associated :instrument
  validates :user, {presence: true}
  validates :instrument, {presence: true}
  validates :title, {presence: true, uniqueness: {scope: :user_id}}
  validates :description, {presence: true}

  serialize(:tags, Array)

  # Corresponds with the name used by accepts_nested_attributes_for.
  # Work-around to enable generic "create" endpoint spec to validate persistance of nested resources.
  def video_parts_attributes
    video_parts.map{|video_part| video_part.serializable_hash(only: [:source_url, :number, :duration]) }
  end

  # Corresponds with the name used by accepts_nested_attributes_for.
  # Work-around to enable generic "create" endpoint spec to validate persistance of nested resources.
  def video_scores_attributes
    video_scores.map{|video_score| video_score.serializable_hash(only: [:image_url, :starts_at, :ends_at]) }
  end

private

  def broadcast_new_video_event_to_artist_followers
    Broadcast.new({
      broadcastable: self,
      event: "NewVideo",
      headline: "#{user.name} posted a new video. Watch it now!",
      users: user.followers
    }).perform
  end
end
