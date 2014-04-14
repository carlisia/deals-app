require 'csv'

class PurchaseImport
  include ActiveModel::Model

  def initialize(attribute='')
    @file = attribute unless !attribute
    @row_entities = {}
    @report_data = {}
  end

  def save
    @report_data[:num_records_imported] = 0
    @report_data[:total_gross_value] = 0.00
    @error_list = []
    CSV.foreach(file.path,
        headers: true,
        :col_sep => "\t",
        :header_converters => [:db_columns],
        :converters => [:all, :blank_to_nil]).each_with_index do |row, row_index|
      build_entities(row)
      if @error_list.size > 0
        @error_list.each do |message|
          errors.add :base, "Row #{row_index+1}: #{message}"
          return false
        end
      end
      @report_data[:num_records_imported] += 1
      @report_data[:total_gross_value] += (@row_entities[:deal].price *
                                     @row_entities[:purchase].count.to_f)
    end
    true
  end

  def prepare_report()
    @report_data[:file_name] = file.original_filename
    @report_data
  end

  def persisted?
    false
  end

  private
  attr_accessor :file

  def build_entities(row)
    @row_entities = {}
    row_attributes = file_layout(row)
    row_attributes.keys.each do |attr_name|
      entity = send("build_#{attr_name}", row_attributes[attr_name])
      break if entity.new_record?
      @row_entities[attr_name] = entity
    end
  end

  def build_merchant(attributes)
    merchant = Merchant.find_or_create_by(attributes)
    build_error_list(merchant)
    merchant
  end

  def build_purchaser(attributes)
    purchaser = Purchaser.find_or_create_by(attributes)
    build_error_list(purchaser)
    purchaser
  end

  def build_deal(attributes)
    merchant = @row_entities[:merchant]
    deal = merchant.deals.find_or_create_by(attributes)
    build_error_list(deal)
    deal
  end

  def build_purchase(attributes)
    purchaser = @row_entities[:purchaser]
    deal = @row_entities[:deal]
    purchase = purchaser.purchases.create(attributes.merge(deal:deal))
    build_error_list(deal)
    purchase
  end

  def build_error_list(entity)
    @error_list << entity.errors.full_messages unless entity.errors.size == 0
  end


  # Note: Using a position-based layout eliminates dependency on column names.
  # Also, different layouts could be used without having to change the code that
  # builds the entities.
  def file_layout(row)
    return {
      merchant:  { name:        row[5],
                  address:     row[4] },
      purchaser: { name:        row[0] },
      deal:      { description: row[1],
                  price:       row[2] },
      purchase:  { count:       row[3] }
     }
  end

  def prepare_error_messages
    imported_purchases.each_with_index do |purchase, index|
      purchase.errors.full_messages.each do |message|
        errors.add :base, "Row #{index+2}: #{message}"
      end
    end
  end

  CSV::Converters[:blank_to_nil] = lambda do |field|
    field && field.empty? ? nil : field
  end

  CSV::HeaderConverters[:db_columns] = lambda do |header|
    header && header.empty? ? nil : header.strip.tr!(' ', '_').to_sym
  end
end