FactoryBot.define do
  factory :task do
    sequence :title do |n|
      "new_title#{n}"
    end
    sequence :description do |n|
      "description#{n}"
    end
    user
  end
end
