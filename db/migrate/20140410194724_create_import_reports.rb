class CreateImportReports < ActiveRecord::Migration
  def change
    create_table :import_reports do |t|
      t.string    :file_name
      t.integer   :num_records_imported
      t.decimal   :total_gross_value, precision: 10, scale: 2

      t.timestamps
    end
  end
end