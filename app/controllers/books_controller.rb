class BooksController < ApplicationController
  def index
    @books = Book.with_tag params[:tag_id]
  end
end
