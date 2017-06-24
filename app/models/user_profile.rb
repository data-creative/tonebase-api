class UserProfile < ApplicationRecord
  belongs_to :user, :inverse_of => :user_profile

  validates_associated :user

  validates :user, {presence:true, uniqueness:true}
  validates :first_name, {presence: true}
  validates :last_name, {presence: true}
  validates :birth_year, {allow_nil: true, numericality: {only_integer: true}}

  def name
    "#{first_name} #{last_name}"
  end
end
