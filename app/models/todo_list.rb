class TodoList < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_and_belongs_to_many :tasks,
    class_name: 'TodoItem', join_table: 'tasks_lists',
    foreign_key: 'list_id', association_foreign_key: 'task_id',
    uniq: true

  scope :unattached, where(project_id: nil)

  validates :title, presence: true

  def to_s
    title
  end

  def as_json options={}
    super(
      :only => [:id, :title, :description],
      :include => [:todo_items]
    )
  end

  def to_param
    "#{id}-#{Russian::transliterate(title).parameterize}"
  end

  def is_complete?
    todo_items.count > 0 &&
      ( todo_items.complete.count == todo_items.count )
  end

  def is_unattached?
    !!project.nil?
  end

end
