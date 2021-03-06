class Assignee < ActiveRecord::Base
  belongs_to :user
  belongs_to :todo_item, touch: true
  belongs_to :assigner, foreign_key: 'assigned_by', class_name: 'User'
end
