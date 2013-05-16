class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :books, through: :taggings
  
  def self.find_or_create(name)
    name.downcase!
    tag = find_by(name: name)
    return tag if tag
    Tag.create(name: name)
  end
  
end
