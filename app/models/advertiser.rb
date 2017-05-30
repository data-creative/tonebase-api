class Advertiser < ApplicationRecord
  serialize(:metadata, Hash)

  validates :name, {presence: true, uniqueness: true}
end
