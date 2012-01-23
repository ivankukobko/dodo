class Admin::InfoPagesController < ApplicationController
  before_filter :require_authorization

  def index
  end

  def new
  end

  def create
    if info_page.save
      redirect_to todo_list, :notice => t(:'info_pages.actions.create.success')
    else
      render :action => "new"
    end
  end

  def show
  end

  def update
    if info_page.update_attributes params[:info_page]
      redirect_to help_path(info_page), :notice => t(:'info_pages.actions.update.success')
    else
      render :action => "edit"
    end
  end

  def destroy
    info_page.destroy
    redirect_to admin_info_index_path
  end

  def info_pages
    @info_pages ||= InfoPage.all
  end
  helper_method :info_pages

  def info_page
    @info_page ||= if params[:id]
      InfoPage.find_by_permalink params[:id]
    else
      InfoPage.new params[:info_page]
    end
  end
  helper_method :info_page

end
