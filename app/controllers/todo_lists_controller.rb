class TodoListsController < ApplicationController
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.js {
        render :json => todo_lists.to_json(
          :except => [ :user_id ],
          :methods => [ :is_complete? ]
        )
      }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.js { render :json => todo_list }
    end
  end

  def new
  end

  def edit
  end

  def create
    params[:todo_list][:user_id] = current_user.id
    if params[:project_id]
      params[:todo_list][:project_id] = project.id
    end
    respond_to do |format|
      if todo_list.save
        format.html { redirect_to todo_list, :notice => t(:'todo_lists.actions.create.success') }
        format.js { render :json => todo_list, :status => :created, :location => todo_list }
      else
        format.html { render :action => "new" }
        format.js { render :json => todo_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if todo_list.update_attributes(params[:todo_list])
        format.html { redirect_to todo_list, :notice =>  t(:'todo_lists.actions.update.success') }
        format.js { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { render :json => todo_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    todo_list.destroy
    respond_to do |format|
      format.html { redirect_to todo_lists_url }
      format.js { head :ok }
    end
  end

  private

  def todo_lists
    @todo_lists ||= current_user.todo_lists.order('created_at DESC')
  end
  helper_method :todo_lists

  def todo_list
    @todo_list ||= if params[:id]
      TodoList.find params[:id]
    else
      TodoList.new params[:todo_list]
    end
  end
  helper_method :todo_list

  def project
    @project ||= if params[:project_id]
      current_user.projects.find params[:project_id]
    end
  end
  helper_method :project

end
