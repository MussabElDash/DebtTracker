class AddCreditorTotalDebtorTotalToUsers < ActiveRecord::Migration

  def self.up

    add_column :users, :creditor_total, :float, :null => false, :default => 0

    add_column :users, :debtor_total, :float, :null => false, :default => 0

  end

  def self.down

    remove_column :users, :creditor_total

    remove_column :users, :debtor_total

  end

end
