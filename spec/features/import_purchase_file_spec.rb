require 'spec_helper'

feature 'User attempts to import a file and' do

  scenario 'sees an upload form' do
    visit root_path
    expect(page).to have_title('DealsApp')
  end

  scenario 'sees a report when the all the data in the file is valid' do
    visit root_path
    file_path = Rails.root + "spec/fixtures/purchase_data.tsv"
    attach_file('file', file_path)
    click_on 'Import File'
    visit purchase_imports_path
    expect(page).to have_content('$95.00')
  end

  scenario 'gets an error message when file is invalid' do
    visit root_path
    file_path = Rails.root + "spec/fixtures/purchase_data-invalid.tsv"
    attach_file('file', file_path)
    click_on 'Import File'
    page.should have_content('error prohibited this import from completing:')
  end

  scenario "gets an alert message when no file is selected" do
      visit root_path
      click_button "Import File"
      page.should have_content('File incorrectly formated or no file selected.')
  end
end