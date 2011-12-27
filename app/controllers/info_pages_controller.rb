class InfoPagesController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

  def info_pages
    @info_pages ||= InfoPage.all
  end

  def info_page
    @info_page ||= if params[:id]
      InfoPage.find_by_permalink params[:id]
    else
      InfoPage.new params[:info_page]
    end
  end
end
