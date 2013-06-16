module BooksHelper
  def tag_filter(tag_ids)
    return unless tag_ids
    content_tag :div, class: ["alert", "alert-info"] do
      content_tag(:div) do # , raw("Viewing books tagged with: #{tag.name} (#{link_to "clear", books_path})"))
        ("Viewing books tagged with: " + Tag.where(id: tag_ids).map { |tag| link_to tag.name, remove_tag_path(tag), 'data-toggle' => "tooltip", title: "Remove", class: "tip" }.join(", ")).html_safe
      end
    end
  end
  
  def tag_links(book)
    raw(book.tags.map { |t| link_to t.name, tag_path(t) }.join(", "))
  end
  
  def download_path(book)
    "#{book.id}/download"
  end
  
end
