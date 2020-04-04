FactoryBot.define do
  factory :hosting_account do
    host_name { "www.example.org" }
    started_on { "2012-01-01" }
    backed_up_on { "2012-01-01" }
    association :domain
  end
end
