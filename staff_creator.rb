#!/usr/bin/ruby

require 'rubygems'
require 'bundler/setup'
require './image_manip.rb'

class StaffCreator
  def initialize(image_path)
    @image_path = image_path
  end #def initialize

  def main
    ImageManip::inspect_image(@image_path)
    dimensions = ImageManip::get_dimensions(@image_path)
    edits = Hash.new
    edits[:upper_left] = [dimensions[0] / 2, 15]
    edits[:bounding_box] = Hash.new
    edits[:bounding_box][:dx] = 2
    edits[:bounding_box][:dy] = 2
    edits[:bounding_box][:rgb_array] = Array.new.fill([[0, 0, 255], [0, 0, 255]], 0..2)
    ImageManip::draw_2D_object(@image_path, './new_staff.jpg', edits)
  end #def main
end #class staff_creator

if __FILE__ == $0
  staff_creator = StaffCreator.new('./Piano_Staff.PNG')
  staff_creator.main
  
end
