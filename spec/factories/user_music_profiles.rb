FactoryGirl.define do
  factory :user_music_profile do
    user
    guitar_owned nil
    guitar_models_owned nil
    fav_composers nil
    fav_performers nil
    fav_periods nil

    trait :owns_guitar do
      guitar_owned true
      guitar_models_owned ["Gibson ABC", "Fender XYZ"]
    end

    trait :with_favs do
      fav_composers ["Bach"]
      fav_performers ["Talenti"]
      fav_periods ["Classical", "Contemporary", "Baroque"]
    end
  end
end
