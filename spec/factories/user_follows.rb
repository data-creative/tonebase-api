FactoryGirl.define do
  factory :user_follow do
    user
    follower
  end
end
