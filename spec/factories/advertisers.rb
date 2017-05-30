FactoryGirl.define do
  factory :advertiser do
    name "Fendie"
    description "The leader in Sitar manufacturing and distribution."
    url "https://www.fendie.com/"
    metadata ({})
  end

  #trait :with_metadata do
  #  metadata ({contact: {name: "Jay", phone: "123456789", email: "jay@fendie.com"}})
  #end
end
