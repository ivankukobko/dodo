class TodoItemsController < ApplicationController

  # TodoItems will definitely be nested resource

  # GET /todo_items
  # GET /todo_items.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => todo_items }
    end
  end

  # GET /todo_items/1
  # GET /todo_items/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => todo_item }
    end
  end

  # GET /todo_items/new
  # GET /todo_items/new.json
  def new
    p "item: #{todo_item.inspect}"
    p "list: #{todo_item.todo_list}"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => todo_item }
    end
  end

  # GET /todo_items/1/edit
  def edit
  end

  # POST /todo_items
  # POST /todo_items.json
  def create
    respond_to do |format|
      if todo_item.save
        format.html { redirect_to todo_item.todo_list, :notice => 'Todo item was successfully created.' }
        format.json { render :json => todo_item, :status => :created, :location => todo_item }
      else
        format.html { render :action => "new" }
        format.json { render :json => todo_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /todo_items/1
  # PUT /todo_items/1.json
  def update
    respond_to do |format|
      if todo_item.update_attributes(params[:todo_item])
        format.html { redirect_to todo_item, :notice => 'Todo item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => todo_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_items/1
  # DELETE /todo_items/1.json
  def destroy
    todo_item.destroy
    respond_to do |format|
      format.html { redirect_to todo_list }
      format.json { head :ok }
    end
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
