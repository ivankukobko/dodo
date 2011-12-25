class CommentsController < ApplicationController
  def index
  end

  def new
  end

  def create
    comment.user = current_user
    comment.todo_item = todo_item
    if comment.save
      flash[:notice] = 'Comment added'
    else
      flash[:error] = 'Cannot create comment'
    end
    redirect_to todo_list_todo_item_path(todo_item.todo_list, todo_item)
  end

  def destroy
    if comment.destroy
      flash[:notice] = 'Comment destroyed'
    end
    redirect_to todo_item
  end

  def comments
    @comments ||= if todo_item.exists?
      todo_item.comments
    end
  end
  helper_method :comments

  def comment
    @comment ||= if params[:id]
      current_user.comments.find params[:id]
    else
      Comment.new params[:comment]
    end
  end
  helper_method :comments

  # FIXME: This one is unsafe! User can post comment to any todo item he
  # enters in params
  def todo_item
    @todo_item ||= if params[:todo_item_id]
      #current_user.todo_items.find params[:todo_item_id]
      TodoItem.find params[:todo_item_id]
    end
  end
end
