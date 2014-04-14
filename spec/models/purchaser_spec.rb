require 'spec_helper'

describe Purchaser do
  context 'validations' do
    it { should have_many(:purchases) }
    it { should validate_presence_of(:name) }
    it { should allow_value(Faker::Name.name).for(:name) }
  end
end