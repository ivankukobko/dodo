class Worklog < ActiveRecord::Base
  belongs_to :user
  belongs_to :todo_item

  validates_presence_of :log_date, :duration, :user_id, :todo_item_id

  default_scope order('log_date DESC')

  scope :by_month, lambda {|date| where('log_date > ? AND log_date < ?', date.beginning_of_month, date.end_of_month)}
  scope :by_week,  lambda {|date| where('log_date > ? AND log_date < ?', date.beginning_of_week, date.end_of_month)}

  #TODO: normalize incoming work duration
  # def duration= value
  #
  # end
end
