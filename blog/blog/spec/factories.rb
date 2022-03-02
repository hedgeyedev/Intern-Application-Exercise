FactoryBot.define do

  factory :user do
    name { "Master Splinter" }
    email {"testemail@mail.com"}
    password { "abcdefghi" }
  end

  factory :post do
    title {"Eggs: Friends or Foe?"}
    post { "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." }
    user
  end

  factory :comment do
    username { "Master Splinter" }
    comment { "MyText" }
    user
  end
end
