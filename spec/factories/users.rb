FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "avg.joe.#{n}@gmail.com)" }
    password "abc123"
    confirmed false
    visible false
    role "User"
    access_level "Limited"
    first_name "Joe"
    last_name "Averaggi"
    bio nil
    image_url nil
    hero_url nil

    trait :confirmed do
      confirmed true
    end

    trait :visible do
      confirmed true
    end

    trait :with_profile do
      bio "I love guitar and I'm hoping to get better!"
      image_url "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg"
      hero_url "https://my-bucket.s3.amazonaws.com/my-dir/hero-image.jpg"
    end

    #
    # FACTORIES
    #

    factory :limited_access_user do
      role "User"
      access_level "Limited"
    end

    factory :full_access_user do
      role "User"
      access_level "Full"
    end

    factory :artist, aliases: [:followed_user] do
      sequence(:email){|n| "music.pro.#{n}@gmail.com)" } # optional to put this attribute here, but it provides further clarity and differentiation
      first_name "Talenti" # optional to put this attribute here, but it provides further clarity and differentiation
      last_name "Pro" # optional to put this attribute here, but it provides further clarity and differentiation
      role "Artist"
      access_level "Full"
    end

    factory :admin do
      sequence(:email){|n| "tonebase.admin.#{n}@gmail.com)" } # optional to put this attribute here, but it provides further clarity and differentiation
      first_name "Tony" # optional to put this attribute here, but it provides further clarity and differentiation
      last_name "Administrato" # optional to put this attribute here, but it provides further clarity and differentiation
      role "Admin"
      access_level "Full"
    end
  end
end
