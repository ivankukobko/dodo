class InfoPage < ActiveRecord::Base
  belongs_to :parent, :class_name => 'InfoPage'
  has_many :children, :class_name => 'InfoPage', :foreign_key => 'parent_id'

  scope :promoted, where(:promote_to_home => true)
  scope :roots, where(:parent_id => nil)

  validates_presence_of :permalink
  validates_uniqueness_of :permalink

  def to_s
    title
  end

  def to_param
    permalink
  end
end
