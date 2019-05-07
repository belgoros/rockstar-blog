FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph }

    for_post

    trait :for_comment do
      association(:commentable, factory: :comment)
    end

    trait :for_post do
      association(:commentable, factory: :post)
    end
  end
end
