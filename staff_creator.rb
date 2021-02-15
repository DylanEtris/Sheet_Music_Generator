#!/usr/bin/ruby

require 'rubygems'
require 'bundler/setup'
require './image_manip.rb'

class StaffCreator
  def initialize(image_path, sharp_path, flat_path)
    @image_path = image_path
    @sharp_path = sharp_path
    @flat_path = flat_path
  end #def initialize

  # Function: get_accidental_pixels
  # Inputs:   path to sharp file
  # Outputs:  None
  # Purpose:  Displays information about the given
  #           image file
  def get_accidental_pixels(accidental_path, log=nil, debug=nil)
    pixels = ImageManip::get_pixels(accidental_path)
    pixels.each_index{ |y|
      pixels[y].each_index{ |x|
        total_rgb = pixels[y][x][0] + pixels[y][x][1] + pixels[y][x][2]
        pixels[y][x] = nil if total_rgb > 255
      }
    }
    return pixels
  end #def get_accidental_pixels

  # Function: main
  # Inputs:   None
  # Outputs:  None
  # Purpose:  Main function
  def main
    ImageManip::inspect_image(@image_path)
    dimensions = ImageManip::get_dimensions(@image_path)
    sharp_pixels = get_accidental_pixels(@sharp_path)
    flat_pixels = get_accidental_pixels(@flat_path)
    edits = Hash.new
    edits[:lower_left] = [dimensions[0] / 2, dimensions[1] / 2]
    edits[:rgb_array] = sharp_pixels
    ImageManip::draw_2D_object(@image_path, './new_staff.gif', edits)
    edits[:lower_left] = [dimensions[0] / 3, dimensions[1] / 3]
    edits[:rgb_array] = flat_pixels
    ImageManip::draw_2D_object('./new_staff.gif', './new_staff.gif', edits)
  end #def main
end #class staff_creator

if __FILE__ == $0
  staff_creator = StaffCreator.new('./pictures/Piano_Staff.gif', './pictures/Sharp.gif', './pictures/Flat.gif')
  staff_creator.main
  
end
