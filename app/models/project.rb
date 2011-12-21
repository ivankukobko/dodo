class Project < ActiveRecord::Base
  has_many :collaborators
  has_many :users, :through => :collaborators
  has_many :todo_lists, :dependent => :destroy
  has_many :todo_items, :through => :todo_lists

  def to_s
    name
  end
end
