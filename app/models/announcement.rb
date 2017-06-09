class Announcement < ApplicationRecord
  validates :title, {presence: true, uniqueness: true}
end
