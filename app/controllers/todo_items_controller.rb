class TodoItemsController < ApplicationController
  inherit_resources
  belongs_to :todo_list

  #def create
    ## TODO: clean this up
    #if params[:todo_item][:assignee_attributes]
      #params[:todo_item][:assignee_attributes][:assigned_by] = current_user.id
    #end
    #respond_to do |format|
      #if todo_item.save
        #format.html { redirect_to todo_list, :notice => t(:'todo_items.actions.create.success') }
        #format.json { render :json => todo_item, :status => :created, :location => todo_item }
      #else
        #format.html { render :action => "new" }
        #format.json { render :json => todo_item.errors, :status => :unprocessable_entity }
      #end
    #end
  #end

  #def update
    ## TODO: clean this up
    #if params[:todo_item][:assignee_attributes]
      #params[:todo_item][:assignee_attributes][:assigned_by] = current_user.id
    #end
    #respond_to do |format|
      #if todo_item.update_attributes(params[:todo_item])
        #format.html { redirect_to todo_item.todo_list, :notice => t(:'todo_items.actions.update.success') }
        #format.json { head :ok }
      #else
        #format.html { render :action => "edit" }
        #format.json { render :json => todo_item.errors, :status => :unprocessable_entity }
      #end
    #end
  #end

  def destroy
    destroy!{ parent_url }
  end

  #def complete
    #respond_to do |format|
      #if todo_item.complete!
        #format.html { redirect_to todo_item.todo_list, :notice => t(:'todo_items.actions.complete.success') }

        #format.json { head :ok }
      #else
        #format.html { redirect_to todo_item.todo_list, :error =>  t(:'todo_items.actions.complete.error') }
        #format.json { render :json => todo_item.errors, :status => :unprocessable_entity }
      #end
    #end
  #end

  #def incomplete
    #respond_to do |format|
      #if todo_item.incomplete!
        #format.html { redirect_to todo_item.todo_list, :notice => t(:'todo_items.actions.incomplete.success') }
        #format.json { head :ok }
      #else
        #format.html { redirect_to todo_item.todo_list, :error =>  t(:'todo_items.actions.incomplete.error')}
        #format.json { render :json => todo_item.errors, :status => :unprocessable_entity }
      #end
    #end
  #end

  def sort
    params[:'todo-item'].each_with_index do |item, index|
      todo_item = TodoItem.find(item)
      todo_item.update_attribute :position, index
    end if params[:'todo-item']
    render :nothing => true
  end

  private

  #def todo_list
    #@todo_list ||= if params[:todo_list_id]
      ## not allowing to access todo_list directly
      #begin
        #current_user.todo_lists_in_projects.find(params[:todo_list_id])
      #rescue ActiveRecord::RecordNotFound
        #current_user.todo_lists.find(params[:todo_list_id])
      #end
    #end
  #end
  #helper_method :todo_list

  #def todo_items
    #@todo_items ||= if todo_list
      #todo_list.todo_items
    #else
      #current_user.todo_items
    #end
  #end
  #helper_method :todo_items

  #def todo_item
    #@todo_item ||= if params[:id]
      #if todo_list
        #todo_list.todo_items.find params[:id]
      #else
        #begin
          #current_user.todo_items.find params[:id]
        #rescue ActiveRecord::RecordNotFound
          #current_user.todo_items_in_projects.find params[:id]
        #end
      #end
    #else
      #todo_list.todo_items.build params[:todo_item]
    #end
  #end
  #helper_method :todo_item

  def todo_list
    parent
  end
  helper_method :todo_list

  def todo_items
    collection
  end
  helper_method :todo_items

  def todo_item
    resource
  end
  helper_method :todo_item
end
