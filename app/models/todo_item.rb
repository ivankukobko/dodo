class TodoItem < ActiveRecord::Base
  belongs_to :todo_list#, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  default_scope order('position ASC, created_at DESC')
  scope :complete, :conditions => { :is_complete => true }
  scope :incomplete, :conditions => { :is_complete => false }

  has_paper_trail

  def complete!
    self.is_complete = true
    self.save
  end

  def incomplete!
    self.is_complete = false
    self.save
  end
end
