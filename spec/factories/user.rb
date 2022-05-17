FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "my#{n}@email.com"
    end
    password { "123456" }
  end

end
