#!/usr/bin/ruby

require "FileUtils"

targetdir = 'Done'

puts "-- Converting all WAV files in this folder to MP3s --"

source_files = Dir.glob('*.wav') 

#check for destination folders/create them
Dir.mkdir("#{targetdir}") unless File.directory?("#{targetdir}")

source_files.each do |file|
  filebase = file.delete ".wav"
  splitted = filebase.split("_-_").map {|s| s.gsub("_"," ") }
  artisttag = splitted[0]
  titletag = splitted[1]    
  lame = "lame -V2 \"#{file}\" \"#{filebase}.mp3\" --ty \"#{Time.now.year}\" --tt \"#{titletag}\" --ta \"#{artisttag}\""
  puts lame
  %x[#{lame}]
  if File.exists?("#{filebase}.mp3") 
    puts ("final file found. cool.")
    FileUtils.move("#{file}","#{targetdir}")
  end
end
  