class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :todo_items, :dependent => :destroy

  def is_complete?
     todo_items.count > 0 &&
       ( todo_items.find(:all, :conditions => { :is_complete => true }).count == todo_items.count )
  end
end
