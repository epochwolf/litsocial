FactoryGirl.define do
  sequence :story_title do |n|
    "Title #{n}"
  end

  factory :story do
    title { generate :story_title }
    contents "Hello World"
    association :user
  end

  factory :series do 
    title { generate :story_title }
    association :user
  end
end