module BooksHelper
  def tag_filter
    return unless @book_tags.present?
    content_tag :div, class: ["alert", "alert-info"] do
      content_tag(:div) do
        ("Viewing books tagged with: " + @book_tags.map { |tag| link_to tag.name, remove_tag_path(tag), 'data-toggle' => "tooltip", title: "Remove", class: "tip" }.join(", ")).html_safe
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
