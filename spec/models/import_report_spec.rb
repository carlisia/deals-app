require 'spec_helper'

describe ImportReport do
  context 'validations' do
    it { should validate_presence_of(:file_name) }
    it { should validate_presence_of(:num_records_imported) }
    it { should validate_presence_of(:total_gross_value) }
    it { should allow_value(generate(:filename)).for(:file_name) }
    it { should allow_value(Faker::Number.number(3)).for(:num_records_imported) }
    it { should allow_value(rand(1..100.0).round(2)).for(:total_gross_value) }
    it { should_not allow_value(0).for(:total_gross_value) }
  end
end