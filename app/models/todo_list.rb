class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :todo_items

  def is_complete?
    todo_items.find(:all, :conditions => { :is_complete => true }).count == todo_items.count
  end
end
