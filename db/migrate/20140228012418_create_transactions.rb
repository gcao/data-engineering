class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :customer, index: true
      t.references :product, index: true
      t.integer :count

      t.timestamps
    end
  end
end
