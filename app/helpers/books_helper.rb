module BooksHelper
  def tag_filter(tag_id)
    return unless tag_id
    tag = Tag.find(tag_id)
    content_tag :div, class: ["alert", "alert-info"] do
      content_tag(:div, raw("Viewing: books tagged with #{tag.name} (#{link_to "clear", books_path})"))
    end
  end
  
  def tag_links(book)
    raw(book.tags.map { |t| link_to t.name, tag_path(t) }.join(", "))
  end
  
end
