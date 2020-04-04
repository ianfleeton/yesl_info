FactoryBot.define do
  factory :admin, class: User do
    name { "Admin" }
    admin { true }
    staff { true }
    email { "admin@example.org" }
    password { "secret" }
    association :organisation
  end

  factory :user do
    name { "Archibald" }
    sequence(:email) { |n| "archibald#{n}@example.org" }
    password { "trustno1" }
    association :organisation
  end
end
