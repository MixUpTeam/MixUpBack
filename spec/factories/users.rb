FactoryBot.define do
  factory :user do
    password { "111111" }

    factory :user_1 do
      email  { "user1_from_factory_bot@yopmail.com" }
    end

    factory :user_2 do
      email  { "user2_from_factory_bot@yopmail.com" }
    end

    factory :user_3 do
      email  { "user3_from_factory_bot@yopmail.com" }
    end
  end
end
