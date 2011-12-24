class TodoList < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :todo_items, :dependent => :destroy

  scope :unattached, :conditions => { :project_id => nil }

  has_paper_trail

  def is_complete?
     todo_items.count > 0 &&
       ( todo_items.find(:all, :conditions => { :is_complete => true }).count == todo_items.count )
  end

  def is_unattached?
    !!project.nil?
  end

end
