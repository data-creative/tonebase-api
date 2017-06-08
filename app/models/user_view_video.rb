class UserViewVideo < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates_associated :user
  validates_associated :video

  validates :user, {presence:true}
  validates :video, {presence:true}

  #scope :recent, lambda { |count| {:limit => count }}
end
