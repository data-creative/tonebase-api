class Announcement < ApplicationRecord
  after_create :broadcast_to_all_users, if: Proc.new{|announcement| announcement.broadcast? }

  has_many :notifications, as: :broadcastable, dependent: :destroy

  validates :title, {presence: true, uniqueness: true}
  validates :broadcast, {inclusion: { in: [true, false] }}

  attr_readonly :broadcast

private

  def broadcast_to_all_users
    Broadcast.new({
      broadcastable: self,
      event: "NewAnnouncement",
      headline: title,
      url: url,
      users: User.all
    }).perform
  end
end
