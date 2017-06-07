FactoryGirl.define do
  factory :user_profile do
    user
    birth_year nil
    professions nil

    trait :with_birth_year do
      birth_year 1975
    end

    trait :with_professions do
      professions ["Student", "Performer", "Instructor"]
    end
  end
end
