class AddProjectIdToTodoList < ActiveRecord::Migration
  def change
    add_column :todo_lists, :project_id, :integer
    add_index :todo_lists, :project_id
  end
end
