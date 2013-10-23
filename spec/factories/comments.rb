# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    comment "MyText"
    user_id 1
    issue_id 1
  end
end
