class Project < ActiveRecord::Base
  has_many :collaborators
  has_many :users, :through => :collaborators
  has_many :todo_lists, :dependent => :destroy

  def to_s
    name
  end
end
