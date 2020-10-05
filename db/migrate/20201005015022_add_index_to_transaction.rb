class AddIndexToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_index :transactions, :ledger_id
    add_index :transactions, [:type, :date]
  end
end
