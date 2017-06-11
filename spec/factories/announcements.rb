FactoryGirl.define do
  factory :announcement do
    sequence(:title){|n| "New Feature #{n}" }
    content nil
    url nil
    image_url nil
    broadcast false

    after(:build) do |announcement|
      announcement.class.skip_callback(:create, :after, :broadcast_to_all_users, raise: false)
    end
#
    trait :with_callbacks do
      after(:build) do |announcement|
        announcement.class.set_callback(:create, :after, :broadcast_to_all_users, if: Proc.new{|announcement| announcement.broadcast? })
      end
    end

    trait :meaningful do
      content "This new feature allows you to do cool things."
      url "https://blog.tonebase.com/posts/new-feature-abc"
      image_url "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg"
    end
  end
end
