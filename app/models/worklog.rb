class Worklog < ActiveRecord::Base
  belongs_to :user
  belongs_to :todo_item

  validates_presence_of :log_date, :duration, :user_id, :todo_item_id

  default_scope order('created_at DESC')

  #TODO: normalize incoming work duration
  # def duration= value
  #
  # end
end
