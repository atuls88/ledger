class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :ledger_id
      t.decimal :amount, precision: 10, scale: 2
      t.date :date
      t.string :type
      t.text :description

      t.timestamps
    end
  end
end
