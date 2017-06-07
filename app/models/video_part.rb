class VideoPart < ApplicationRecord
  belongs_to :video

  validates_associated :video
  validates :video, {presence: true}
  validates :source_url, {presence: true}
  validates :number, {presence: true, numericality: { only_integer: true }, uniqueness: {scope: :video_id}}
  validates :duration, {presence: true, numericality: { only_integer: true }}
end
