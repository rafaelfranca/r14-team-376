class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      (resource.is_a?(User) ?  organization_url(resource.organization) : super)
  end
end
