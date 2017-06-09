class Video < ApplicationRecord
  after_create :broadcast_new_video_event_to_artist_followers

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

#private

  def broadcast_new_video_event_to_artist_followers
    Broadcast.new({
      broadcastable: self,
      event: "NewVideo",
      title: "#{user.name} posted a new video. Watch it now!",
      users: user.followers
    })
  end
end

class Broadcast
  # @param [Hash] options
  # @param [Hash] options [ApplicationRecord] broadcastable The resource which triggered this broadcast. The focus of attention.
  # @param [Hash] options [String] event The type of event that triggered this broadcast.
  # @param [Hash] options [String] headline The notification headline a user will see in their inbox.
  # @param [Hash] options [String] url An optional url to redirect a user who clicks on the notification headline in their inbox.
  # @param [Hash] options [Array] users A list of users to be notified.
  #
  # @example
  #
  #   Broadcast.create({
  #     broadcastable: <Video>,
  #     event: "NewVideo",
  #     headline: "Talenti Pro posted a new video. Watch it now!"
  #     users: [<User>, <User>, <User>]
  #   })
  #
  def initialize(options = {})
    @broadcastable = options[:broadcastable]
    @event = options[:event]
    @headline = options[:headline]
    @url = options[:url]
    @users = options[:users]
  end

  def broadcastable_type
    @broadcastable.class.name
  end

  def broadcastable_id
    @broadcastable.id
  end
end
