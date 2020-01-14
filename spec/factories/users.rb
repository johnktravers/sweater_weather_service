FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { SecureRandom.hex }
    api_key { SecureRandom.hex }
    password_confirmation { 'password' }
  end
end
