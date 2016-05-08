FactoryGirl.define do
  factory :user do
    password = Faker::Internet.password

    email { Faker::Internet.email }
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    password { password }
    password_confirmation { password }

    factory :user_with_posts do
      transient do
        posts_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end

  factory :post do
    title 'Sample Post'
    body  'lorem ipsum dolor'
    user
  end

  factory :comment do
    body  'lorem ipsum dolor'
    user
    post
  end
end
