class InfoPage < ActiveRecord::Base
  belongs_to :parent, :class_name => 'InfoPage'
end
