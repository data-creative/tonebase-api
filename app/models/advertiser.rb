class Advertiser < ApplicationRecord
  serialize(:metadata, Hash)

  validates :name, {presence: true, uniqueness: true}

  has_many :ads
end
