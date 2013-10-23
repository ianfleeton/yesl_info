FactoryGirl.define do
  factory :issue do
    title 'Help!'
    association :assignee, factory: :user
    association :setter, factory: :user
    association :organisation
  end
end
