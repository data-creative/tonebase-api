FactoryGirl.define do
  factory :video do
    user
    instrument
    title "Finale from Sonata #99"
    #sequence(:title){|n| "Finale from Sonata ##{90 + n})" }
    description "The final moments of master composer Maestrelli's most famous piece. Composed in 1817."
    tags nil

    trait :tagged do
      tags ["borouque", "maestrelli", "g-major"]
    end
  end
end
