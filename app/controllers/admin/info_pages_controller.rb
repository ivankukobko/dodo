class Admin::InfoPagesController < ApplicationController
  inherit_resources
  defaults finder: :find_by_permalink

  before_filter :require_authorization

  def create
    create!{collection_url}
  end

  def update
    update!{collection_url}
  end

  private

  def info_pages
    collection
  end
  helper_method :info_pages

  def info_page
    resource
  end
  helper_method :info_page

end
