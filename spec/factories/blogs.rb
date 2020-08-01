FactoryBot.define do
  factory :blog do
    user { nil }
    title { "MyString" }
    body { "MyText" }
    status { 1 }
  end
end
