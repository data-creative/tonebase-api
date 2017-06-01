FactoryGirl.define do
  factory :advertiser do
    sequence(:name){|n| "Fendie (#{n})" }
    description ""
    url ""

    trait :described do
      description "The leader in Sitar manufacturing and distribution."
    end

    trait :with_url do
      url "https://www.fendie.com/"
    end
  end
end
