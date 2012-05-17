class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  has_many :comments, :dependent => :destroy
  has_one  :assignee, :dependent => :destroy
  accepts_nested_attributes_for :assignee
  has_many :worklogs, :dependent => :destroy

  default_scope order('is_complete ASC, position ASC, created_at DESC')
  scope :complete,   :conditions => { :is_complete => true }
  scope :incomplete, :conditions => { :is_complete => false }

  has_paper_trail

  def to_s
    title
  end

  def complete!
    self.is_complete = true
    save
  end

  def incomplete!
    self.is_complete = false
    save
  end

  def expired?
    if due_date && !is_complete
      p "#{title} - #{due_date} - #{Time.now + 1.days}"
      due_date < (Time.now - 1.days)
    end
  end
end
