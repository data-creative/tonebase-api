class User < ApplicationRecord
  has_one :user_profile, inverse_of: :user, dependent: :destroy
  has_one :user_music_profile, inverse_of: :user, dependent: :destroy
  alias :profile :user_profile
  alias :music_profile :user_music_profile
  accepts_nested_attributes_for :user_profile
  accepts_nested_attributes_for :user_music_profile

  has_many :user_followships, dependent: :destroy
  has_many :follows, through: :user_followships, source: :followed_user
  has_many :inverse_user_followships, class_name: UserFollowship, foreign_key: "followed_user_id", dependent: :destroy
  has_many :followers, through: :inverse_user_followships, source: :user

  has_many :videos, dependent: :destroy

  has_many :user_favorite_videos, dependent: :destroy
  has_many :favorite_videos, through: :user_favorite_videos, source: :video

  has_many :user_view_videos, dependent: :destroy
  alias :video_views :user_view_videos
  alias :views :user_view_videos
  has_many :viewed_videos, -> { distinct }, through: :user_view_videos, source: :video
  # @deprecated converted to has_many association for eager-loading
  #scope :recent_video_views, -> {
  #  joins(:user_view_videos)
  #    .group(:video_id)
  #    .select("video_id, max(user_view_videos.created_at) AS most_recently_viewed_at")
  #    .order("max(user_view_videos.created_at) DESC")
  #}
  has_many :recent_video_views, -> {
    group(:video_id).select("video_id, max(user_view_videos.created_at) AS most_recently_viewed_at").order("max(user_view_videos.created_at) DESC")
  }, class_name: "UserViewVideo"

  ROLES = ["User", "Artist", "Admin"]

  validates :email, {presence: true, uniqueness: true}
  validates :password, {presence: true}
  validates :username, {presence: true, uniqueness: true}
  validates :confirmed, {inclusion: {in: [true, false] }}
  validates :visible, {inclusion: { in: [true, false] }}
  validates :role, {presence: true, inclusion: { in: ROLES }}
  validates :access_level, {presence: true, inclusion: { in: ["Full", "Limited"] }}

  def self.user
    where(role: "User")
  end

  def self.artist
    where(role: "Artist")
  end

  def self.admin
    where(role: "Admin")
  end

  # Corresponds with the name used by accepts_nested_attributes_for.
  # Work-around to enable generic "create" endpoint spec to validate persistance of nested resources.
  def user_profile_attributes
    user_profile.try(:serializable_hash, only: [:first_name, :last_name, :bio, :image_url, :hero_url, :birth_year, :professions]) || {}
  end

  # Corresponds with the name used by accepts_nested_attributes_for.
  # Work-around to enable generic "create" endpoint spec to validate persistance of nested resources.
  def user_music_profile_attributes
    user_music_profile.try(:serializable_hash, only: [:guitar_owned, :guitar_models_owned, :fav_composers, :fav_performers, :fav_periods]) || {}
  end

  def image_url
    profile.try(:image_url) || "https://my-bucket.s3.amazonaws.com/my-dir/default-twitter-egg.png"
  end

  def name
    profile.try(:name) || "Un-named User"
  end

  # @deprecated converted to a scope so it can be eager-loaded.
  # Should correspond with the following query:
  #
  #    SELECT
  #      video_id
  #      ,max(created_at) as most_recently_viewed_at
  #    FROM user_view_videos
  #    where user_id = 123
  #    GROUP BY video_id
  #    ORDER BY most_recently_viewed_at DESC
  #
  # @return [#<UserViewVideo id: nil, video_id: 852>, #<UserViewVideo id: nil, video_id: 851>, #<UserViewVideo id: nil, video_id: 850>]
  #def recent_video_views
  #  video_views
  #    .group(:video_id)
  #    .select("video_id, max(user_view_videos.created_at) AS most_recently_viewed_at")
  #    .order("max(user_view_videos.created_at) DESC")
  #end
end
