class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :todo_item, touch: true
  belongs_to :parent, class_name: 'Comment'
end
