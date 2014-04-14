class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.belongs_to  :deal
      t.belongs_to  :purchaser
      t.integer     :count

      t.timestamps
    end
  end
end