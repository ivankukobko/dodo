class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :todo_item
      t.references :parent
      t.text :body

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :todo_item_id
    add_index :comments, :parent_id
  end
end
