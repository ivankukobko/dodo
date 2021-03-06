require 'humanize_duration'

class Worklog < ActiveRecord::Base

  include HumanizeDuration

  attr_accessible :log_date, :duration_human, :todo_item_id

  belongs_to :user
  belongs_to :todo_item
  # delegate :todo_list, :to => :todo_item
  delegate :project, :to => :todo_item

  validates_presence_of :duration, :user_id, :todo_item_id

  default_scope order('log_date DESC')
  scope :billed, where(:is_billed => true)
  scope :unbilled, where(:is_billed => false)

  scope :by_month, lambda {|date| where('log_date > ? AND log_date < ?', date.beginning_of_month, date.end_of_month)}
  scope :by_week,  lambda {|date| where('log_date > ? AND log_date < ?', date.beginning_of_week, date.end_of_month)}

end
