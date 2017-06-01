FactoryGirl.define do
  factory :ad do
    advertiser
    sequence(:title){|n| "Buy a Fendie (#{n})" }
    content ""
    url ""
    image_url ""

    trait :with_content do
      content "Fendie sitars are the best."
    end

    trait :with_url do
      url "https://www.fendie.com/promo"
    end

    trait :with_image do
      image_url "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg"
    end
  end
end
