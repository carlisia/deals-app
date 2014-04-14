class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.belongs_to  :merchant
      t.text        :description
      t.decimal     :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end