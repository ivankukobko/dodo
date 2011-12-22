class Project < ActiveRecord::Base
  has_many :collaborators
  has_many :users, :through => :collaborators
  has_many :todo_lists, :dependent => :destroy
  has_many :todo_items, :through => :todo_lists

  after_create :assign_owner

  def to_s
    name
  end

  def assign_owner
    collaborators.first.update_attributes( :accepted_at => Time.now.utc )
  end

end
