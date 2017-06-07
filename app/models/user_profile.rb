class UserProfile < ApplicationRecord
  belongs_to :user

  validates_associated :user

  validates :user, {presence:true, uniqueness:true}
  validates :birth_year, {allow_nil: true, numericality: {only_integer: true}}

  serialize(:professions, Array)
end
