class Advertiser < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}

  has_many :ads
end
