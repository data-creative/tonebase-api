FactoryGirl.define do
  factory :video_score do
    video
    image_url "https://my-bucket.s3.amazonaws.com/my-dir/score-1-image.jpg"
    starts_at 1
    ends_at 75
  end
end
