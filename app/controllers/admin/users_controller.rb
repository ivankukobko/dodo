class Admin::UsersController < ApplicationController
  inherit_resources
  defaults class_name: 'User'
  before_filter :require_authorization
end
