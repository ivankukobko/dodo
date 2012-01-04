class CreateAssignees < ActiveRecord::Migration
  def change
    create_table :assignees do |t|
      t.references :user
      t.references :todo_item
      t.integer    :assigned_by

      t.timestamps
    end
    add_index :assignees, :user_id
    add_index :assignees, :todo_item_id
    add_index :assignees, :assigned_by
  end
end
