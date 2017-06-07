class Instrument < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}

  has_many :ad_instruments, dependent: :destroy
  has_many :ads, through: :ad_instruments
end
