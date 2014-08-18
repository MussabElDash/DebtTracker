class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.decimal :amount
      t.decimal :remaining
      t.string :currency
      t.boolean :confirmed
      t.text :description

      t.references :creditor
      t.references :debtor

      t.timestamps
    end
  end
end
