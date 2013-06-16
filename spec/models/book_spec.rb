require 'spec_helper'

describe Book do
  it "can be tagged" do
    book = Book.new title: "Test Book", author: "Test Author"
    tag = Tag.new name: "Testing"
    
    expect(book.tags.include? tag).to be_false
    
    book.tags << tag
    
    expect(book.tags.include? tag).to be_true
  end
  
  it "can have multiple tags" do
    book = Book.new title: "Test Book", author: "Test Author"
    tag1 = Tag.new name: "Testing"
    tag2 = Tag.new name: "Multiple tags"
    
    expect(book.tags.include? tag1).to be_false
    expect(book.tags.include? tag2).to be_false
    
    book.tags << tag1
    
    expect(book.tags.include? tag1).to be_true
    expect(book.tags.include? tag2).to be_false
    
    book.tags << tag2
    
    expect(book.tags.include? tag1).to be_true
    expect(book.tags.include? tag2).to be_true
    
  end
  
  it "can find by tags" do
    book1 = Book.new title: "Test Book", author: "Test Author", description: "Details"
    book2 = Book.new title: "Another Test Book", author: "Test Author", description: "Details"
    book1.save validate: false
    book2.save validate: false
    tag = Tag.create name: "Testing"
    book1.tags << tag
    
    expect(Book.with_tags(Array tag.id).first).to eq(book1)
    
  end
  
end