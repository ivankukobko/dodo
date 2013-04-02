class Project < ActiveRecord::Base
  has_many :collaborators
  has_many :users, :through => :collaborators
  has_many :todo_lists, :dependent => :destroy
  has_many :todo_items, :through => :todo_lists
  has_many :invitations, :dependent => :destroy
  has_many :worklogs, :through => :todo_items

  def to_s
    name
  end

  def as_json options={}
    super(
      :only => [:id, :name, :description],
      :include => [
        :todo_lists => { :include => :todo_items }
      ]
    )
  end

  def to_param
    "#{id}-#{Russian::transliterate(name).parameterize}"
  end

  def collaborator user
    collaborators.find_by_user_id user.id
  end

end
