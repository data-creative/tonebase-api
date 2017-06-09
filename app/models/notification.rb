class Notification < ApplicationRecord
  belongs_to :broadcastable, polymorphic: true

  has_many :user_notifications, dependent: :destroy

  EVENT_TYPES = ["NewVideo"]

  validates_associated :broadcastable
  validates :broadcastable, {presence: true}
  validates :event, {
    presence: true,
    inclusion: {in: EVENT_TYPES},
    uniqueness: {scope: [:broadcastable_type, :broadcastable_id]}
  }
  validates :headline, {presence: true}
end
