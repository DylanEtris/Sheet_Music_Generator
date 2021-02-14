#!/usr/bin/ruby

require 'rubygems'
require 'bundler/setup'
require 'mini_magick'

module ImageManip
  # Function: inspect_image
  # Inputs:   path to image file
  # Outputs:  None
  # Purpose:  Displays information about the given
  #           image file
  def self.inspect_image(img_file, log=nil, debug=nil)
    image = MiniMagick::Image.open(img_file)
    puts "Image Dimensions: #{image.dimensions}"
    puts "Image Type: #{image.type}"
    puts "Image Size: #{image.human_size}"
  end #def inspect_image

  # Function: get_pixels
  # Inputs:   path to image file
  # Outputs:  An array of pixels
  # Purpose:  Reads an image and returns pixels
  def self.get_pixels(img_file, log=nil, debug=nil)
    image = MiniMagick::Image.open(img_file)
    return image.get_pixels
  end #def get_dimensions

  # Function: get_dimensions
  # Inputs:   path to image file
  # Outputs:  An array of image dimensions
  # Purpose:  Reads an image and returns dimensions
  def self.get_dimensions(img_file, log=nil, debug=nil)
    image = MiniMagick::Image.open(img_file)
    return image.dimensions
  end #def get_dimensions

  # Function: draw_2D_object
  # Inputs:   img_file - Path to input image
  #           output_file - Path to output image
  #           image_edits - [{ coordinates: {dx: 2, dy: 2, upper_left: [0, 0]},
  #                            rgb_array: [255, 255, 255] [0, 255, 255] Visual array;
  #                                       [0, 255, 255]   [0, 0, 0]     Not syntactically correct
  #                          },
  #                          {...}
  #                          ...]
  # Outputs:  None. Writes to external file
  # Purpose:  1. Opens the image
  #           2. Goes to the coordinates of the
  #              bounding boxes and changes the RGB
  #              vals within it
  #           3. Writes to the output file
  def self.draw_2D_object(img_file, output_file, edit, log=nil, debug=nil)
  image = MiniMagick::Image.open(img_file)
  pixels = image.get_pixels
  dimensions = [image.width, image.height]
  depth = 8
  map = 'rgb'

  dx = edit[:rgb_array].length
  dy = edit[:rgb_array][0].length
  upper_left = edit[:upper_left]
  (0..dx-1).each{ |dx|
    (0..dy-1).each{ |dy|
      x = upper_left[0] + dx
      y = upper_left[0] + dy
      raise StandardError, 'pixel is not within image bounds' unless x >= 0 && x < dimensions[0]
      raise StandardError, 'pixel is not within image bounds' unless y >= 0 && x < dimensions[1]
      rgb = edit[:rgb_array][dx][dy]
      pixels[x][y] = rgb unless rgb == nil
    }
  }
  
  image = MiniMagick::Image.get_image_from_pixels(pixels, dimensions, map, depth, 'gif') 

  image.write(output_file)
  end #def self.image_manip
end #module ImageManip
