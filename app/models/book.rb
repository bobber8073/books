class Book < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  validates :title, :author, :description, presence: true
  
  mount_uploader :pdf, BookUploader
  validates :pdf, :presence => true, :unless => :pdf_exists?
  
  def self.with_tags(serialized_tags)
    return Book.all unless serialized_tags
    tags = Marshal.load serialized_tags
    Book.where id: Tagging.select("book_id").where("tag_id" => tags).group("book_id").having("count(tag_id) >= ?", tags.count).map(&:book_id)
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
