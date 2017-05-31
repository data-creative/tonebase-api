FactoryGirl.define do
  factory :advertiser do
    name "Fendie"
    description ""
    url ""
    metadata ({})

    trait :described do
      description "The leader in Sitar manufacturing and distribution."
    end

    trait :with_url do
      url "https://www.fendie.com/"
    end

    trait :with_metadata do
      metadata ({
        contact: {
          name:"My Industry Contact",
          phone: "123456789",
          emailed_on: ["2017-05-01", "2017-05-02", "2017-05-03"]
        }
      }) # ... some unstructured hash resembling this one
    end
  end
end
