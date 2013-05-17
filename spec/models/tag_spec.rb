require 'spec_helper'

describe Tag do
  it "tags an book" do
    book = Book.new title: "Test Book", author: "Test Author"
    tag = Tag.new name: "Testing"
    
    expect(tag.books.include? book).to be_false
    
    tag.books << book
    
    expect(tag.books.include? book).to be_true
  end
  
  it "can have multiple books" do
    book1 = Book.new title: "Test Book", author: "Test Author"
    book2 = Book.new title: "Another Test Book", author: "Test Author"
    tag = Tag.new name: "Testing"
    
    expect(tag.books.include? book1).to be_false
    expect(tag.books.include? book2).to be_false
    
    tag.books << book1
    
    expect(tag.books.include? book1).to be_true
    expect(tag.books.include? book2).to be_false
    
    tag.books << book2
    
    expect(tag.books.include? book1).to be_true
    expect(tag.books.include? book2).to be_true
    
  end
  
  
end