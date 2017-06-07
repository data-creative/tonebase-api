class VideoScore < ApplicationRecord
  belongs_to :video

  validates_associated :video
  validates :video, {presence: true}
  validates :image_url, {presence: true}
  validates :starts_at, {presence: true, numericality: { only_integer: true }}
  validates :ends_at, {presence: true, numericality: { only_integer: true }}
end
