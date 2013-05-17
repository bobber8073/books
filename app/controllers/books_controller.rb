class BooksController < ApplicationController
  
  def index
    @books = Book.with_tag params[:tag_id]
  end
  
  def new
    expires_now
    @book = Book.new
    add_breadcrumb "New Book", new_book_path
  end
  
  def create
    expires_now
    @book = Book.new(book_params)
    @book.tag_names = params[:book][:tag_names]
    if @book.save
      flash[:notice] = "#{@book.title} added"
      redirect_to books_path
    else
      flash[:error] = "Yikes! Please check the form for any errors."
      render action: "new"
    end
  end
  
  def show
    @book = Book.find params[:id]
    add_breadcrumb @book.title, book_path(@book)
  end
  
  def edit
    expires_now
    @book = Book.find params[:id]
    add_breadcrumb @book.title, book_path(@book)    
  end
  
  def update
    expires_now
    @book = Book.find params[:id]
    @book.update_attributes!(book_params)   
    @book.tag_names = params[:book][:tag_names]
    if @book.save
      flash[:notice] = "#{@book.title} updated"
      redirect_to books_path
    else
      flash[:error] = "Yikes! Please check the form for any errors."
      render action: "edit"
    end      
  end
  
  def destroy
    @book = Book.find params[:id]
    if @book.destroy
      flash[:warning] = "\"#{@book.title}\" was deleted."
    else
      flash[:error] = "Yikes! Something went wrong; try again later."
    end
    redirect_to books_path
  end
  
  def book_params
    params.require(:book).permit(:title, :author, :pdf, :description)
  end
end
