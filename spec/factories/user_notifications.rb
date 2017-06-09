FactoryGirl.define do
  factory :user_notification do
    user nil
    notification nil
    marked_read false
  end
end
