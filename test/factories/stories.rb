FactoryGirl.define do
  sequence :story_title do |n|
    "Title #{n}"
  end

  factory :story do
    title { generate :story_title }
    contents "Hello World"
    association :user
  end
end