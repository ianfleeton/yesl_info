FactoryBot.define do
  factory :timesheet_entry do
    association :organisation
    description { "Refactored" }
    started_at { Date.yesterday }
  end
end
