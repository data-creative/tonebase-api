FactoryGirl.define do
  factory :user do
    email "MyString"
    password "MyString"
    confirmed false
    visible false
    role "MyString"
    access_level "MyString"
    first_name "MyString"
    last_name "MyString"
    bio "MyText"
    image_url "MyString"
    hero_url "MyString"
  end
end
