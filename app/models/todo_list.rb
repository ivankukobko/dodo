class TodoList < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :todo_items, :dependent => :destroy

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
