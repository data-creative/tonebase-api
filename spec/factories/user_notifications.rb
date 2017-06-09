FactoryGirl.define do
  factory :user_notification do
    user
    notification
    marked_read false
  end
end
