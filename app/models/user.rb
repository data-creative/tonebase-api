class User < ApplicationRecord
  has_many :user_followships
  has_many :follows, :through => :user_followships, :source => :followed_user

  has_many :inverse_user_followships, :class_name => UserFollowship, :foreign_key => "followed_user_id"
  has_many :followers, :through => :inverse_user_followships, :source => :user

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
end
