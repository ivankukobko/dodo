class WorklogsController < ApplicationController

  def index

  end

  def new

  end

  def create

  end

  # get worklogs for current_project or
  def worklogs
    @worklogs ||= todo_item.worklogs
  end
  helper_method :worklogs

  def todo_item
    @todo_item ||= if params[:todo_item_id]
      TodoItem.find params[:todo_item_id]
    end
  end

end
