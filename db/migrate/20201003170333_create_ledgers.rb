class CreateLedgers < ActiveRecord::Migration[6.0]
  def change
    create_table :ledgers do |t|
      t.string :name
      t.decimal :starting_balance, precision: 10, scale: 2

      t.timestamps
    end
  end
end
