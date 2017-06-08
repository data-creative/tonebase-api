class VideoScore < ApplicationRecord
  belongs_to :video, inverse_of: :video_scores

  validates_associated :video
  validates :video, {presence: true}
  validates :image_url, {presence: true}
  validates :starts_at, {presence: true, numericality: { only_integer: true }}
  validates :ends_at, {presence: true, numericality: { only_integer: true }}
end
