FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "avg.joe.#{n}@gmail.com)" }
    password "abc123"
    sequence(:username){|n| "joe#{n}" }
    confirmed false
    visible false
    role "User"
    access_level "Limited"
    customer_uuid nil
    oauth nil
    oauth_provider nil

    trait :customer do
      customer_uuid "cus_abc123def45678"
    end

    trait :confirmed do
      confirmed true
    end

    trait :visible do
      confirmed true
    end

    trait :with_oauth do
      oauth true
      oauth_provider "Google"
    end

    trait :with_profile do
      after(:create) do |user, evaluator|
        create(:user_profile, user: user)
      end
    end

    trait :follower do
      after(:create) do |user, evaluator|
        3.times do |i|
          artist = create(:artist)
          create(:user_followship, user: user, followed_user: artist)
        end
      end
    end

    trait :with_favorite_videos do
      after(:create) do |user, evaluator|
        3.times do |i|
          video = create(:video)
          create(:user_favorite_video, user: user, video: video)
        end
      end
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
      sequence(:email){|n| "music.pro.#{n}@gmail.com)" }
      sequence(:username){|n| "pro#{n}" }
      role "Artist"
      access_level "Full"

      trait :with_profile do
        after(:create) do |artist, evaluator|
          create(:user_profile,
            user: artist,
            first_name: "Talenti",
            last_name: "Pro",
            birth_year: 1975,
            professions: ["Performer", "Instructor"],
            bio: "My music. My passion.",
            image_url: "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg",
            hero_url: "https://my-bucket.s3.amazonaws.com/my-dir/hero-image.jpg"
          )
        end
      end

      trait :with_followers do
        after(:create) do |artist, evaluator|
          3.times do |i|
            user = create(:user)
            create(:user_followship, user: user, followed_user: artist)
          end
        end
      end
    end

    factory :admin do
      sequence(:email){|n| "tonebase.admin.#{n}@gmail.com)" }
      sequence(:username){|n| "admin#{n}" }
      role "Admin"
      access_level "Full"

      trait :with_profile do
        after(:create) do |user, evaluator|
          create(:user_profile, user: user, first_name: "Tony", last_name: "Administrato")
        end
      end
    end
  end
end
