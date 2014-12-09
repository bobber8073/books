# encoding: utf-8
require 'carrierwave/processing/mini_magick'

class BookUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    Rails.root.join("uploads", model.class.to_s.underscore, mounted_as.to_s, model.id.to_s).to_s
  end

  def convert_to_png
    file = @file.instance_eval {@file}
    img = MiniMagick::Image.new("#{file}[0]")
    img.resize "220x285"
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
  
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(pdf)
  end
   
end
