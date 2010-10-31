#!/usr/bin/ruby
require "FileUtils"

#----------------------------------------
# Setup variables
#----------------------------------------

targetdir = 'Originals'

#----------------------------------------
# Methods
#----------------------------------------

def convert(source_files,targetdir)
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
      puts ("\nEncoded file found. Cool.\n\n")
      FileUtils.move("#{file}","#{targetdir}")
    end
  end
end

#----------------------------------------
# Process
#----------------------------------------

source_files = Dir.glob('*.wav')
if source_files.empty? then
    puts "\nNo .WAV found in this folder.\n\n"
else
    puts "\nConverting all WAV files in this folder to MP3s. When done the WAV can be found in the /#{targetdir} folder\n\n"
    convert(source_files,targetdir)
end