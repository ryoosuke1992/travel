FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "とても楽しそうですね！" }
    association :plan
  end
end
