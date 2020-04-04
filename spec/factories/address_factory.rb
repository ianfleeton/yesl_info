FactoryBot.define do
  factory :address do
    address_line_1 { "Street" }
    association :organisation
  end
end
