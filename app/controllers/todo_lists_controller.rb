class TodoListsController < ApplicationController
  # GET /todo_lists
  # GET /todo_lists.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => todo_lists }
    end
  end

  # GET /todo_lists/1
  # GET /todo_lists/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => todo_list }
    end
  end

  # GET /todo_lists/new
  # GET /todo_lists/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => todo_list }
    end
  end

  # GET /todo_lists/1/edit
  def edit
  end

  # POST /todo_lists
  # POST /todo_lists.json
  def create
    respond_to do |format|
      if todo_list.save
        format.html { redirect_to todo_list, :notice => 'Todo list was successfully created.' }
        format.json { render :json => todo_list, :status => :created, :location => todo_list }
      else
        format.html { render :action => "new" }
        format.json { render :json => todo_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /todo_lists/1
  # PUT /todo_lists/1.json
  def update
    respond_to do |format|
      if todo_list.update_attributes(params[:todo_list])
        format.html { redirect_to todo_list, :notice => 'Todo list was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => todo_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_lists/1
  # DELETE /todo_lists/1.json
  def destroy
    todo_list.destroy
    respond_to do |format|
      format.html { redirect_to todo_lists_url }
      format.json { head :ok }
    end
  end

  private

  def todo_lists
    @todo_lists = TodoList.all
  end
  helper_method :todo_lists

  def todo_list
    @todo_list = if params[:id]
      TodoList.find params[:id]
    else
      TodoList.new params[:todo_list]
    end
  end
  helper_method :todo_list
end
