class UserMusicProfile < ApplicationRecord
  belongs_to :user, inverse_of: :user_music_profile

  validates_associated :user

  validates :user, {presence:true, uniqueness:true}

  serialize(:guitar_models_owned, Array)
  serialize(:fav_composers, Array)
  serialize(:fav_performers, Array)
  serialize(:fav_periods, Array)
end
