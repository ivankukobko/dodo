class Project < ActiveRecord::Base
  has_many :collaborators
  has_many :users, :through => :collaborators
  has_many :todo_lists, :dependent => :destroy
  has_many :todo_items, :through => :todo_lists
  has_many :invitations, :dependent => :destroy

  after_create :assign_owner

  has_paper_trail

  def to_s
    name
  end

  def assign_owner
    #collaborators.first.update_attributes( :accepted_at => time.now.utc )
  end

  def collaborator user
    collaborators.find_by_user_id user.id
  end

end
