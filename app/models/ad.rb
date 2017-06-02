class Ad < ApplicationRecord
  validates_associated :advertiser
  validates :advertiser, {presence: true}
  validates :title, {presence: true}

  belongs_to :advertiser
  has_many :ad_placements
  has_many :ad_instruments
  has_many :instruments, through: :ad_instruments

  alias :placements :ad_placements
end
