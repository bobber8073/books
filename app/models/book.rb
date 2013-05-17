class Book < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  validates :title, :author, :description, presence: true
  
  mount_uploader :pdf, BookUploader
  validates :pdf, :presence => true, :unless => :pdf_exists?
  
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
  
  def pdf_exists?
    pdf.path.present?
  end
  
end
