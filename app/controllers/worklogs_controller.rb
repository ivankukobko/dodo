class WorklogsController < ApplicationController

  def index
  end

  def create
    if worklog.save
      respond_to do |format|
        format.html { redirect_to worklog.todo_item }
        format.json { render :json => worklog }
      end
    else
      p todo_item
      p worklog.errors
      render :new
    end
  end

  def update
    if worklog.update_attributes(params[:worklog])
      flash[:success] = t('worklog.update.success')
    else
      flash[:error] = t('worklog.update.error')
    end
    redirect_to 'index'
  end

  def destroy
    if worklog.destroy
      flash[:success] = t('worklog.destroy.success')
    end
    redirect_to 'index'
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

  # get worklogs for current_project or current_user
  def worklogs
    @worklogs ||= if todo_item
      todo_item.worklogs
    elsif project
      project.worklogs
    else
      current_user.worklogs
      #Worklog.all
    end
  end
  helper_method :worklogs

  def todo_item
    @todo_item ||= if params[:todo_item_id]
      TodoItem.find params[:todo_item_id]
    end
  end
  helper_method :todo_item

  def project
    @project ||= if params[:project_id]
      current_user.projects.find params[:project_id]
    end
  end

  def worklog
    @worklog ||= if params[:id]
      current_user.worklogs.find params[:id]
    elsif todo_item
      w = current_user.worklogs.build params[:worklog]
      w.todo_item_id = todo_item.id
      w.log_date = Time.now
      w
    end
  end
  helper_method :worklog

end
