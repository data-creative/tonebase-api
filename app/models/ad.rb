class Ad < ApplicationRecord
  validates :advertiser, {presence: true}
  validates :title, {presence: true}

  belongs_to :advertiser
end
