FactoryGirl.define do
  factory :video do
    user
    instrument
    title "Finale from Sonata #99" # consider ... sequence(:title){|n| "Finale from Sonata ##{90 + n})" }
    description "The final moments of master composer Maestrelli's most famous piece. Composed in 1817."
    tags nil

    trait :tagged do
      tags ["borouque", "maestrelli", "g-major"]
    end

    trait :with_parts_and_scores do
      after(:create) do |video, evaluator|
        create(:video_part, video: video, source_url: "https://www.youtube.com/watch?v=abc123", duration: 333)
        create(:video_part, video: video, source_url: "https://www.youtube.com/watch?v=def456", duration: 333)
        create(:video_part, video: video, source_url: "https://www.youtube.com/watch?v=ghi789", duration: 333)

        create(:video_score, video: video, image_url: "https://my-bucket.s3.amazonaws.com/my-dir/score-1-image.jpg", starts_at: 25, ends_at: 500)
        create(:video_score, video: video, image_url: "https://my-bucket.s3.amazonaws.com/my-dir/score-2-image.jpg", starts_at: 750, ends_at: 900)
      end
    end
  end
end
