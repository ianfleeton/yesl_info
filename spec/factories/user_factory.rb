FactoryGirl.define do
  factory :admin, class: User do
    name        'Admin'
    admin       true
    staff       true
    email       'admin@example.org'
    password    'secret'
    association :organisation
  end
end
