module ApplicationHelper
  
  def tag_path(tag)
    books_path(tag_id: tag.id)
  end
  
  def user_info
    if current_user
      link_to "Welcome, #{current_user.username}", destroy_user_session_path, :method => :delete
    else
      link_to "Sign In", new_user_session_path
    end
  end
  
end

