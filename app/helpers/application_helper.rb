module ApplicationHelper
  
  def tag_path(tag)
    if params[:tags]
      books_path(tags: Marshal.dump(Marshal.load(params[:tags]).append(tag.id)))
    else
      books_path(tags: Marshal.dump(Array tag.id))
    end
  end
  
  def remove_tag_path(tag)
    tag_ids = Marshal.load(params[:tags])
    tag_ids.delete(tag.id)
    tag_ids.empty? ? books_path : books_path(tags: Marshal.dump(tag_ids))
  end
  
end

