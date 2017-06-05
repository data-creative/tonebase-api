class AdInstrument < ApplicationRecord
  belongs_to :ad
  belongs_to :instrument

  validates_associated :ad
  validates_associated :instrument
  validates :ad, {presence:true}
  validates :instrument, {presence:true, uniqueness: {scope: :ad_id}}
end
