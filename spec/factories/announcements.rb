FactoryGirl.define do
  factory :announcement do
    sequence(:title){|n| "New Feature #{n}" }
    content nil
    url nil
    image_url nil

    trait :meaningful do
      content "This new feature allows you to do cool things."
      url "https://blog.tonebase.com/posts/new-feature-abc"
      image_url "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg"
    end
  end
end
