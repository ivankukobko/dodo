class TodoItemsController < ApplicationController

  # TodoItems will definitely be nested resource

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => todo_items }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => todo_item }
    end
  end

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => todo_item }
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if todo_item.save
        format.html { redirect_to todo_list, :notice => t(:'todo_items.actions.create.success') }
        format.json { render :json => todo_item, :status => :created, :location => todo_item }
      else
        format.html { render :action => "new" }
        format.json { render :json => todo_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if todo_item.update_attributes(params[:todo_item])
        format.html { redirect_to todo_item.todo_list, :notice => t(:'todo_items.actions.update.success') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => todo_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    todo_item.destroy
    respond_to do |format|
      format.html { redirect_to todo_list }
      format.json { head :ok }
    end
  end

  def complete
    respond_to do |format|
      if todo_item.complete!
        format.html { redirect_to todo_item.todo_list, :notice => t(:'todo_items.actions.complete.success') }

        format.json { head :ok }
      else
        format.html { redirect_to todo_item.todo_list, :error =>  t(:'todo_items.actions.complete.error') }
        format.json { render :json => todo_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def incomplete
    respond_to do |format|
      if todo_item.incomplete!
        format.html { redirect_to todo_item.todo_list, :notice => t(:'todo_items.actions.incomplete.success') }
        format.json { head :ok }
      else
        format.html { redirect_to todo_item.todo_list, :error =>  t(:'todo_items.actions.incomplete.error')}
        format.json { render :json => todo_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def sort
    params[:'todo-item'].each_with_index do |item, index|
      #todo_list.todo_items.update_all :order => index, :id => item
      # TODO: remove dangerous mass-assignment
      todo_item = TodoItem.find(item)
      todo_item.update_attribute :position, index
    end if params[:'todo-item']
    render :nothing => true
  end

  private

  def todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end
  helper_method :todo_list

  def todo_items
    @todo_items = todo_list.todo_items
  end
  helper_method :todo_items

  def todo_item
    @todo_item = if params[:id]
      TodoItem.find params[:id]
    else
      todo_list.todo_items.build params[:todo_item]
    end
  end
  helper_method :todo_item
end
