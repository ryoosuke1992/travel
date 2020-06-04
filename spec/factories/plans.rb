FactoryBot.define do
  factory :plan do
    title { Faker::Book.title }
    date { "2021年4月1日" }
    place { "ハワイ" }
    meeting_place { "ハワイ空港" }
    meeting_time { "13:00" }
    content { "ハワイの綺麗な海を一緒に眺めましょう！" }
    association :user
  end
  trait :image do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/travel.jpg')) }
  end
end
