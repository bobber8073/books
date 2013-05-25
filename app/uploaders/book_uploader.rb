# encoding: utf-8
require 'carrierwave/processing/rmagick'

class BookUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    Rails.root.join("uploads", model.class.to_s.underscore, mounted_as.to_s, model.id.to_s).to_s
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  def scale(width, height)
    # do something
  end

  def convert_to_png
    file = @file.instance_eval {@file}
    puts "CHASE::{{[[#{file}]]}}"
    img = Magick::Image.read(file + "[0]").first
    img.resize!(220, 285)
    img.write(file + ".png")
    @file.instance_eval do 
      @file = file + ".png"
      @content_type = "application/png"
    end
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process :convert_to_png
    process :convert => 'png'
    def full_filename (for_file = model.logo.file) 
      "#{for_file}.png" 
    end
    def store_dir
      "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
    
  end
  
  # version :big do
  #   process :convert_to_png
  # end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(pdf)
  end
   
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
