class AddIsBilledToWorklogs < ActiveRecord::Migration
  def change
    add_column :worklogs, :is_billed, :boolean, :default => false
  end
end
