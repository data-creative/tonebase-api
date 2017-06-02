class AdPlacement < ApplicationRecord
  belongs_to :ad

  validates_associated :ad
  validates :ad, {presence: true}
  validates :start_date, {presence: true}
  validates :end_date, {presence: true}
  validates :price, {presence: true, numericality: { only_integer: true }}
end
