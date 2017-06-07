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
      #first_name "Talenti" # optional to put this attribute here, but it provides further clarity and differentiation
      #last_name "Pro" # optional to put this attribute here, but it provides further clarity and differentiation
      role "Artist"
      access_level "Full"
    end

    factory :admin do
      sequence(:email){|n| "tonebase.admin.#{n}@gmail.com)" } # optional to put this attribute here, but it provides further clarity and differentiation
      #first_name "Tony" # optional to put this attribute here, but it provides further clarity and differentiation
      #last_name "Administrato" # optional to put this attribute here, but it provides further clarity and differentiation
      role "Admin"
      access_level "Full"
    end

    trait :customer do
      customer_uuid "cus_abc123def45678"
    end
  end
end
