FactoryBot.define do 
  factory :profile do
    sequence :nickname do |n|
      "NickName#{n}"
    end

    sequence :bio do |n|
      "Bio#{n}"
    end
    
    user

    trait :with_avatar do
      avatar { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-image.png'), 'image/png') }
    end

    share { false }
  end
end
