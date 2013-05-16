class Book < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  
  def self.with_tag(tag_id)
    return Book.all unless tag_id
    Tag.find(tag_id).books
  end
  
end
