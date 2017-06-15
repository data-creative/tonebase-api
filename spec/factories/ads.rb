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

    trait :with_placements do
      after(:create) do |ad, evaluator|
        create(:ad_placement, ad: ad, start_date: "2017-07-01", end_date: "2017-07-15", price: 25000)
        create(:ad_placement, ad: ad, start_date: "2017-08-01", end_date: "2017-08-15", price: 25000)
        create(:ad_placement, ad: ad, start_date: "2017-09-01", end_date: "2017-09-15", price: 25000)
      end
    end

    trait :with_instruments do
      after(:create) do |ad, evaluator|
        instrument = create(:instrument)
        create(:ad_instrument, ad: ad, instrument: instrument)
      end
    end
  end
end
