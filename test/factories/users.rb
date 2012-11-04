FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :username do |n|
    "person#{n}"
  end

  factory :user do
    name { generate(:username) }
    email { generate(:email) }
    password "Password"
    admin false
    biography "I am the token member"
  end

  factory :admin, class: User do 
    name { generate(:username) }
    email { generate(:email) }
    password "Password"
    admin true
    biography "I am the admin"
  end

  factory :user_with_watchers, class: User do
    name { generate(:username) }
    email { generate(:email) }
    password "Password"
    admin false
    biography "I am the token member with a fan or two"

    after(:create){ |user|
      2.times do 
        create(:user).watches.create(watchable: user)
      end
    }
  end

end