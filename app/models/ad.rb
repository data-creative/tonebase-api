class Ad < ApplicationRecord
  validates_associated :advertiser
  validates :advertiser, {presence: true}
  validates :title, {presence: true}

  belongs_to :advertiser
end
