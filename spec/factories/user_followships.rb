FactoryGirl.define do
  factory :user_followship do
    user
    followed_user
  end
end
