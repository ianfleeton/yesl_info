FactoryGirl.define do
  factory :domain do
    name          'example.org'
    registered_on '2012-01-01'
    association   :organisation
  end
end
