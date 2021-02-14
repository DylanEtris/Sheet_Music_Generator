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
    pixels.each{ |row|
      row.each{ |col|
        total_rgb = col[0] + col[1] + col[2]
        if total_rgb < 382
          pixels[row][col] = nil
        end
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
    edits = Hash.new
    edits[:upper_left] = [dimensions[0] / 2, 15]
    edits[:rgb_array] = sharp_pixels
    ImageManip::draw_2D_object(@image_path, './new_staff.gif', edits)
  end #def main
end #class staff_creator

if __FILE__ == $0
  staff_creator = StaffCreator.new('./Piano_Staff.png', './Sharp.png', './Flat.png')
  staff_creator.main
  
end
