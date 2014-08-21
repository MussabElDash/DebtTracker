class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.float :amount,    null: false
      t.float :remaining, null: false
      t.string :currency, null: false
      t.datetime :confirmed_at
      t.text :description, null: false, default: ''

      t.references :creditor, null: false
      t.references :debtor  , null: false

      t.timestamps
    end
    add_index :debts, :creditor_id
    add_index :debts, :debtor_id
  end
end
