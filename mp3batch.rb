#!/usr/bin/ruby
require "FileUtils"

#Setup variables
targetdir = 'Done'

#Go!
puts "-- Converting all WAV files in this folder to MP3s. When done the WAV can be found in the /done folder --"
source_files = Dir.glob('*.wav') 
Dir.mkdir("#{targetdir}") unless File.directory?("#{targetdir}")

source_files.each do |file|
  filebase = file.delete ".wav"
  splitted = filebase.split("_-_").collect {|s| s.gsub("_"," ") }
  artisttag = splitted[0]
  titletag = splitted[1]    
  lame = "lame -V2 \"#{file}\" \"#{filebase}.mp3\" --ty \"#{Time.now.year}\" --tt \"#{titletag}\" --ta \"#{artisttag}\""
  puts lame
  %x[#{lame}]
  if File.exists?("#{filebase}.mp3") 
    puts ("Encoded file found. Cool.")
    FileUtils.move("#{file}","#{targetdir}")
  end
end
  