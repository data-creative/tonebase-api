class Ad < ApplicationRecord
  validates_associated :advertiser
  validates :advertiser, {presence: true}
  validates :title, {presence: true}

  belongs_to :advertiser
  has_many :ad_placements

  alias :placements :ad_placements
end
