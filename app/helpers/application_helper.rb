module ApplicationHelper
  
  def tag_path(tag)
    books_path(tag_id: tag.id)
  end
  
end

