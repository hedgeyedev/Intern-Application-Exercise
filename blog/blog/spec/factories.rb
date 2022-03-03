require 'faker'
FactoryBot.define do

  factory :user do
    name { "Master Splinter" }
    email { Faker::Internet.email }
    password { "abcdefghi" }
  end

  factory :post do
    title {"Eggs: Friends or Foe?"}
    post { "kjlkjlj;lkj;lkj;lkjklj;lkj;lkj;kljk" }
    user
  end

  factory :comment do
    username { "Master Splinter" }
    comment { "MyText" }
    association :user, factory: :user
    post
  end
end
