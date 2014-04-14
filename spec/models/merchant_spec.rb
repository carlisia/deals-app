require 'spec_helper'

describe Merchant do
  context 'validations' do
    it { should have_many(:deals) }
    it { should have_many(:purchasers) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should allow_value(Faker::Name.name).for(:name) }
    it { should allow_value(Faker::Address.street_address).for(:address) }
  end
end