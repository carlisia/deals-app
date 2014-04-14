require 'spec_helper'

describe Purchase do
  context 'validations' do
    it { should belong_to(:purchaser) }
    it { should belong_to(:deal) }
    it { should validate_presence_of(:count) }
    it { should allow_value(10).for(:count) }
    it { should_not allow_value(10.50).for(:count) }
    it { should_not allow_value(0).for(:count) }
  end
end
