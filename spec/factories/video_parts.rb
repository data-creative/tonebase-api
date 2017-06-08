FactoryGirl.define do
  factory :video_part do
    video
    source_url "https://www.youtube.com/watch?v=abc123"
    number 1
    duration 333
  end
end
