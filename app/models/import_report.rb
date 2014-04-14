class ImportReport < ActiveRecord::Base
  validates :file_name, presence: true
  validates :num_records_imported, presence: true, numericality: { greater_than: 0 }
  validates :total_gross_value, presence: true, numericality: { greater_than: 0 }
end