FactoryBot.define do
  factory :participant do
    association :user
    association :plan
  end
end