class User < ApplicationRecord
  has_many :user_followships
  has_many :follows, :through => :user_followships, :source => :followed_user
  has_many :inverse_user_followships, :class_name => UserFollowship, :foreign_key => "followed_user_id"
  has_many :followers, :through => :inverse_user_followships, :source => :user

  has_many :user_favorite_videos
  has_many :favorite_videos, :through => :user_favorite_videos, :source => :video

  has_one :user_profile, :inverse_of => :user
  alias :profile :user_profile
  accepts_nested_attributes_for :user_profile

  has_one :user_music_profile, :inverse_of => :user
  alias :music_profile :user_music_profile
  accepts_nested_attributes_for :user_music_profile

  ROLES = ["User", "Artist", "Admin"]

  validates :email, {presence: true, uniqueness: true}
  validates :password, {presence: true}
  validates :confirmed, {inclusion: {in: [true, false] }}
  validates :visible, {inclusion: { in: [true, false] }}
  validates :role, {presence: true, inclusion: { in: ROLES }}
  validates :access_level, {presence: true, inclusion: { in: ["Full", "Limited"] }}
  validates :first_name, {presence: true}
  validates :last_name, {presence: true}

  def self.user
    where(:role => "User")
  end

  def self.artist
    where(:role => "Artist")
  end

  def self.admin
    where(:role => "Admin")
  end

  def username
    "#{first_name} #{last_name}" # consider implementing a real, persisted username attribute
  end

  # Work-around to enable "create" endpoint spec to validate persistance of nested resources!
  def user_profile_attributes
    #user_profile.serializable_hash(only: [:birth_year, :professions])
    user_profile.try(:serializable_hash, only: [:birth_year, :professions]) # try because not all users will have a profile (or should they?).
  end

  # Work-around to enable "create" endpoint spec to validate persistance of nested resources!
  def user_music_profile_attributes
    user_music_profile.try(:serializable_hash, only: [:guitar_owned, :guitar_models_owned, :fav_composers, :fav_performers, :fav_periods]) # try because not all users will have a music profile (or should they?).
  end
end
