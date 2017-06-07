FactoryGirl.define do
  factory :user_profile do
    user
    first_name "Joe"
    last_name "Averaggi"
    bio nil
    image_url nil
    hero_url nil
    birth_year nil
    professions nil

    trait :full do
      bio "I love guitar and I'm hoping to get better!"
      image_url "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg"
      hero_url "https://my-bucket.s3.amazonaws.com/my-dir/hero-image.jpg"
      birth_year 1993
      professions ["Student", "Performer", "Instructor"]
    end
  end
end
