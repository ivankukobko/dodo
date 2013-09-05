class Project < ActiveRecord::Base
  has_many :collaborators
  has_many :users, through: :collaborators
  has_many :todo_lists, :dependent => :destroy

  has_many :todo_items
  has_many :tasks, class_name: 'TodoItem'

  has_many :invitations, dependent: :destroy
  has_many :worklogs, through: :todo_items

  validates :name, presence: true

  scope :shared_with, lambda{ |u|
    includes(:users).where(collaborators: {user_id: u})
  }

  def to_s
    name
  end

  def as_json options={}
    super(
      :only => [:id, :name, :description],
      :include => [
        :include => :todo_items
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
