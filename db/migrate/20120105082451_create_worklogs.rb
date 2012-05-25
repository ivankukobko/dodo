class CreateWorklogs < ActiveRecord::Migration
  def change
    create_table :worklogs do |t|
      t.references :user
      t.references :todo_item
      t.date :log_date
      t.integer :duration

      t.timestamps
    end
    add_index :worklogs, :user_id
    add_index :worklogs, :todo_item_id
  end
end
