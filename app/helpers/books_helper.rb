module BooksHelper
  def tag_filter(tag_id)
    return unless tag_id
    tag = Tag.find(tag_id)
    content_tag :div, class: ["alert", "alert-info"] do
      content_tag(:div, raw("Books with tag: #{tag.name} (#{link_to "clear", books_path})"))
    end
  end
end
