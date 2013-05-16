class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_tags
  add_breadcrumb :index, :root_path
  
  def load_tags
    @tags = Tag.joins(:books).uniq
  end
  
end
