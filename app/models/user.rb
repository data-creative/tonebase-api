class User < ApplicationRecord
  has_many :user_followships, dependent: :destroy
  has_many :follows, through: :user_followships, source: :followed_user
  has_many :inverse_user_followships, class_name: UserFollowship, foreign_key: "followed_user_id", dependent: :destroy
  has_many :followers, through: :inverse_user_followships, source: :user

  has_many :videos, dependent: :destroy

  has_many :user_favorite_videos, dependent: :destroy
  has_many :favorite_videos, through: :user_favorite_videos, source: :video

  has_one :user_profile, inverse_of: :user, dependent: :destroy
  has_one :user_music_profile, inverse_of: :user, dependent: :destroy
  alias :profile :user_profile
  alias :music_profile :user_music_profile
  accepts_nested_attributes_for :user_profile
  accepts_nested_attributes_for :user_music_profile

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
    profile.try(:image_url) || "https://my-bucket.s3.amazonaws.com/my-dir/some-default-twitter-egg-image.png"
  end
end
