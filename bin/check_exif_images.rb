#!/usr/bin/env ruby

require 'exifr'

config = {
  convert: false
}

if ARGV[0] == "-convert"
  config[:convert] = true
end

def check_file(file)
  file_type = determine_type(file)
  if file_type == "JPEG"
    EXIFR::JPEG.new(file).exif?
  elsif file_type == "TIFF"
    EXIFR::TIFF.new(file).exif?
  end
end

def determine_type(file)
  `identify -format '%m ' "#{file}"`.split(' ').first
end

def convert_file(file)
  puts "converting #{file}"
  `convert "#{file}" -scale 100% -strip "#{file}"`
end

files = `find public/system/{reports,teams} -type f`.split("\n")
files.each do |file|
  if check_file(file)
    puts file
    if config[:convert]
      convert_file(file)
    end
  end
end
