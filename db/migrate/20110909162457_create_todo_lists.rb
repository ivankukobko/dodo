class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :title
      t.text :description
      t.references :user

      t.timestamps
    end
    add_index :todo_lists, :user_id
  end
end
