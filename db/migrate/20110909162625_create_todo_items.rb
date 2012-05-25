class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string      :title
      t.text        :description
      t.references  :todo_list
      t.boolean     :is_complete, :default => false

      t.timestamps
    end
  end
end
