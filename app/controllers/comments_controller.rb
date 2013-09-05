class CommentsController < ApplicationController
  inherit_resources
  respond_to :html, :js
  belongs_to :todo_item

  def create
    # TODO: find out how to set these attributes implicitly
    @comment = Comment.new params[:comment]
    @comment.user_id = current_user.id
    @comment.todo_item_id = parent.id
    create! {parent_url}
  end

  def destroy
    destroy! {parent_url}
  end

  def update
    update! {parent_url}
  end

  protected

  def begin_of_association_chain
    current_user
  end

  def comment
    resource
  end
  helper_method :comment

end
