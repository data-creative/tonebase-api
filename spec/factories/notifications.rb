FactoryGirl.define do
  factory :notification do
    broadcastable nil
    event "MyString"
    headline "MyString"
    url "MyString"
  end
end
