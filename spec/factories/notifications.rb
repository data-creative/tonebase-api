FactoryGirl.define do
  factory :notification do
    association :broadcastable, factory: :video
    event "NewVideo"
    headline "Some Artist has posted a new video. Watch it now!"
    url nil
  end
end
