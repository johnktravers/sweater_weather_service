require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email}
    it { should validate_uniqueness_of :email}
    it { should validate_presence_of :api_key }
    it { should validate_uniqueness_of :api_key }
    it { should validate_length_of(:api_key).is_equal_to(32) }
    it { should validate_presence_of :password_confirmation }
  end
end
