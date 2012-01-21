class Admin::InfoPagesController < ApplicationController
  before_filter :require_authorization

  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

  def info_pages
    @info_pages ||= InfoPage.all
  end

  def info_page
    @info_pages ||= if params[:id]
      InfoPage.find params[:id]
    else
      InfoPage.new params[:info_page]
    end
  end

end
