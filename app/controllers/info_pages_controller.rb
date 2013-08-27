class InfoPagesController < ApplicationController
  skip_before_filter :require_authentication

  def index
  end

  def show
  end

  def info_pages
    @info_pages ||= InfoPage.roots
  end
  helper_method :info_pages

  def info_page
    @info_page ||= if params[:id]
      InfoPage.find_by_permalink params[:id]
    end
  end
  helper_method :info_page
end
