FactoryGirl.define do
  factory :notification do
    association :broadcastable, factory: :video

    #association :broadcastable, factory: :video, id: 1501, title: "Unique Video"

    #sequence(:broadcastable, 1000) do |n|
    #  association :broadcastable, factory: :video, id: n
    #end

    event "NewVideo"
    headline "Some Artist has posted a new video. Watch it now!"
    url nil
  end
end
