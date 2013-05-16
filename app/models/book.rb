class Book < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  validates :title, :author, presence: true
  
  def self.with_tag(tag_id)
    return Book.all unless tag_id
    Tag.find(tag_id).books
  end
  
  def tag_names=(tags)
    self.taggings.destroy_all
    tags.split(",").map(&:strip).each do |t|
      tag = Tag.find_or_create(t)
      self.tags << tag
    end
    self
  end
  
  def tag_names
    tags.map(&:name).join(", ")
  end
  
end
