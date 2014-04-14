require 'spec_helper'

feature 'User attempts to import a file and' do

  scenario 'sees an upload form' do
    visit root_path
    expect(page).to have_title('DealsApp')
  end

  scenario 'sees a report of only the imported file when the all the data in the file is valid' do
    visit root_path
    purchase_count = Purchase.count
    file_path = Rails.root + "spec/fixtures/purchase_data.tsv"
    attach_file('file', file_path)
    click_on 'Import File'
    expect(page).to have_content('95.0')
    expect(page).not_to have_content('All Reports List')
    expect(Purchase.count).to eq purchase_count + 4
  end

  scenario 'gets an error message when file is invalid' do
    visit root_path
    purchase_count = Purchase.count
    file_path = Rails.root + "spec/fixtures/purchase_data-invalid.tsv"
    attach_file('file', file_path)
    click_on 'Import File'
    page.should have_content('error prohibited this import from completing:')
    expect(Purchase.count).to eq purchase_count
  end

  scenario 'gets an error message when file is invalid and rolls back saved transactions' do
    visit root_path
    purchase_count = Purchase.count
    file_path = Rails.root + "spec/fixtures/purchase_data-invalid2.tsv"
    attach_file('file', file_path)
    click_on 'Import File'
    page.should have_content('error prohibited this import from completing:')
    expect(Purchase.count).to eq purchase_count
  end

  scenario "gets an alert message when no file is selected" do
      visit root_path
      click_button "Import File"
      page.should have_content('File incorrectly formated or no file selected.')
  end
end