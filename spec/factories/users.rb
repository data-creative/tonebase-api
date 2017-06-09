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
          create(:user_profile, user: artist, first_name: "Talenti", last_name: "Pro", birth_year: 1975, professions: ["Performer", "Instructor"])
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

    trait :customer do
      customer_uuid "cus_abc123def45678"
    end
  end
end
