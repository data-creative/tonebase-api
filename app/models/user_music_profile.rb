class UserMusicProfile < ApplicationRecord
  belongs_to :user, inverse_of: :user_music_profile

  validates_associated :user

  validates :user, {presence:true, uniqueness:true}
end
