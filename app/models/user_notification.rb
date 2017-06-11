class UserNotification < ApplicationRecord
  belongs_to :user
  belongs_to :notification

  validates_associated :user
  validates_associated :notification

  validates :user, {presence: true}
  validates :notification, {presence: true, uniqueness: {scope: :user_id}}
end
