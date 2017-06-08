class UserViewVideo < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates_associated :user
  validates_associated :video

  validates :user, {presence:true}
  validates :video, {presence:true}

  #alias :viewed_at :created_at
end
