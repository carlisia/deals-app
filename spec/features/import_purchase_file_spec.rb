require 'spec_helper'

feature 'User attempts to import a file and' do
  scenario 'sees an upload form' do
    visit new_purchase_import_url
    expect(page).to have_title('DealsApp')
    expect(page).to have_content('Please select a file to import')
  end

  scenario 'sees a report of only the imported file when the all the data in the file is valid' do
    visit new_purchase_import_url
    purchase_count = Purchase.count
    file_path = Rails.root + "spec/fixtures/purchase_data.tsv"
    attach_file('file', file_path)
    click_on 'Import File'
    expect(page).to have_content('95.0')
    expect(page).not_to have_content('All Reports List')
    expect(Purchase.count).to eq purchase_count + 4
  end

  scenario 'gets an error message when file is invalid' do
    visit new_purchase_import_url
    purchase_count = Purchase.count
    file_path = Rails.root + "spec/fixtures/purchase_data-invalid.tsv"
    attach_file('file', file_path)
    click_on 'Import File'
    page.should have_content('error prohibited this import from completing:')
    expect(Purchase.count).to eq purchase_count
  end

  scenario 'gets an error message when file is invalid and rolls back saved transactions' do
    visit new_purchase_import_url
    purchase_count = Purchase.count
    file_path = Rails.root + "spec/fixtures/purchase_data-invalid2.tsv"
    attach_file('file', file_path)
    click_on 'Import File'
    page.should have_content('error prohibited this import from completing:')
    expect(Purchase.count).to eq purchase_count
  end

  scenario "gets an alert message when no file is selected" do
      visit new_purchase_import_url
      click_on "Import File"
      page.should have_content('File incorrectly formated or no file selected.')
  end
end

feature 'User navigates through top menu' do
  scenario 'and sees all reports' do
    report = create(:import_report)
    visit import_reports_url
    expect(page).to have_content(report.total_gross_value)
    expect(page).to have_content(report.file_name)
  end
end