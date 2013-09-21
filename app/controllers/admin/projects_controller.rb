class Admin::ProjectsController < ApplicationController
  inherit_resources
  defaults class_name: 'Project'
  before_filter :require_authorization
  belongs_to :user, optional: true
end

