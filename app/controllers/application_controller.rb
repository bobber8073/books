class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_tags
  add_breadcrumb :index, :root_path
    
  private
  
  def load_tags
    @tags = Tag.joins(:books).uniq
  end
  
  protected

  def devise_parameter_sanitizer
    if resource_class.is_a?(User)
      User::ParameterSanitizer.new(User, :user, params)
    else
      super # Use the default one
    end
  end
  
  
end
