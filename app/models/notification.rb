class Notification < ApplicationRecord
  belongs_to :broadcastable, polymorphic: true
end
