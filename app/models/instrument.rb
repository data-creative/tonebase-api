class Instrument < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}

  has_many :ad_instruments
  has_many :ads, through: :ad_instruments
end
