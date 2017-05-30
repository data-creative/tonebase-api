class Advertiser < ApplicationRecord
  serialize(:metadata, Hash)

  validates :name, {presence: true, uniqueness: true}

  #def metadata
  #  self[:metadata].try(:symbolize_keys)
  #end
end
