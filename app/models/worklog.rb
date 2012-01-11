class Worklog < ActiveRecord::Base
  belongs_to :user
  belongs_to :todo_item

  #TODO: normalize incoming work duration
  # def duration= value
  #
  # end
end
