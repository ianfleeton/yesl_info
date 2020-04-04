FactoryBot.define do
  factory :organisation do
    sequence(:name) {|n| "Your e Solutions Ltd #{n}"}
    last_contacted { Date.yesterday }
  end
end
