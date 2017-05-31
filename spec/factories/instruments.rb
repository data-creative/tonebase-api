FactoryGirl.define do
  factory :instrument do
    name "Sitar"
    description ""

    trait :described do
      description "The sitar is a plucked stringed instrument used mainly in Hindustani music and Indian classical music." # source: wikipedia
    end
  end
end
