FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { SecureRandom.hex }
    api_key { SecureRandom.hex }
  end
end
