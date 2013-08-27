class BrakeDataStructuresAndSaveTheWorld < ActiveRecord::Migration
  def up
    create_table :tasks_lists, id: false do |t|
      t.integer :list_id, null: false
      t.integer :task_id, null: false
    end
    add_index :tasks_lists, [:list_id, :task_id]

    add_column :todo_items, :project_id, :integer
    add_column :todo_items, :user_id, :integer

    TodoItem.all.each do |task|
      list = TodoList.find task.todo_list_id
      task.lists = [list]
      task.project_id = list.project_id
      task.user_id = list.user_id
      task.save
    end

    remove_column :todo_items, :todo_list_id
  end

  def down
    puts 'No way back!'
  end
end
