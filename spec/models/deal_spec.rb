require 'spec_helper'

describe Deal do
  context 'validations' do
    it { should have_many(:purchases) }
    it { should belong_to(:merchant) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should allow_value("This is a deal description").for(:description) }
    it { should allow_value(rand(1..100.0).round(2)).for(:price) }
  end
end