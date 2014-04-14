require 'faker'

FactoryGirl.define do
  sequence :filename do |n|
    "filename-#{n}.tsv"
  end

  factory :purchase do
    count { Faker::Number.number(2) }
  end

  factory :merchant do
    name    { Faker::Company.name }
    address { Faker::Address.street_address }
  end

  factory :purchaser do
    name    { Faker::Name.name }
  end

  factory :deal do
    description   { Faker::Lorem.sentences(1) }
    price         { rand(1..100.0).round(2) }
  end

  factory :import_report do
    file_name               { generate(:filename) }
    num_records_imported    { Faker::Number.number(2) }
    total_gross_value       { 760.80 }
  end
end