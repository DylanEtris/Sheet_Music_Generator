#!/usr/bin/ruby

require 'rubygems'
require 'bundler/setup'

require 'mini_magick'

class StaffCreator
  def self.inspect_image(img_file, log=nil, debug=nil)
    image = MiniMagick::Image.open(img_file)
    puts "Image Dimensions: #{image.dimensions}"
    puts "Image Type: #{image.type}"
    puts "Image Size: #{image.human_size}"
  end
end #class staff_creator

if __FILE__ == $0
  StaffCreator.inspect_image('./Piano_Staff.PNG')
end
