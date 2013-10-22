FactoryGirl.define do
  factory :issue do
    title 'Help!'
    association :setter, factory: :user
    association :organisation
  end
end
