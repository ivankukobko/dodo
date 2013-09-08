class WorklogsController < ApplicationController
  inherit_resources

  belongs_to :project, optional: true do
    belongs_to :task, class_name: 'TodoItem', param: :todo_item_id, optional: true
  end

  def new
    redirect_to(:back, alert: "Can add logs for tasks only") and return unless todo_item
  end

  def update
    update!{collection_url}
  end

  def create
    build_resource.user_id = current_user.id
    build_resource.todo_item_id = todo_item.id
    build_resource.log_date = Time.now
    create!{parent_url}
  end

  def bill
    worklog.is_billed = true
    worklog.save
    redirect_to :back
  end

  def unbill
    worklog.is_billed = false
    worklog.save
    redirect_to :back
  end

private

  def begin_of_association_chain
    current_user unless parent?
  end

  def worklogs
    collection
  end
  helper_method :worklogs

  def worklog
    params[:id] ? resource : build_resource
  end
  helper_method :worklog

  def todo_item
    @todo_item ||= parent if parent? && parent.is_a?(TodoItem)
  end
  helper_method :todo_item

end
