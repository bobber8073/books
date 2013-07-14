class Book < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  validates :title, :author, :description, presence: true
  
  mount_uploader :pdf, BookUploader
  validates :pdf, :presence => true, :unless => :pdf_exists?
  
  def self.with_tags(tags)
    return Book.all unless tags && tags.respond_to?(:map)
    Book.where id: Tagging.select("book_id").where("tag_id" => tags.map(&:to_i)).group("book_id").having("count(tag_id) >= ?", tags.count).map(&:book_id)
  end
  
  def set_tag_names(tags)
    self.taggings.destroy_all
    tags.split(",").map(&:strip).each do |t|
      tag = Tag.find_or_create(t)
      self.tags << tag
    end
    self
  end
  
  def tag_names=(tag_names)
    @tag_names = tag_names
  end
  
  def tag_names
    @tag_names ||= tags.map(&:name).join(", ")
  end
  
  def pdf_exists?
    pdf.path.present?
  end
  
end
