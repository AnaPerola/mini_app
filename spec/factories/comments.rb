FactoryBot.define do
  factory :comment do
    sequence :body do |n|
      "Body#{n}"
    end
    like_status { 0 }
  end
end
