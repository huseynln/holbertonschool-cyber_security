#!/usr/bin/env ruby

require 'open-uri'

def download
    if ARGV.empty?
        puts "Usage: 9-download_file.rb URL LOCAL_FILE_PATH"
    else
        url = ARGV[0]
        path = ARGV[1]

        URI.open(url) do |file|
            puts "Downloading file from #{url}"
            File.open(path, 'wb') do |out|
                out.write(file.read)
                puts "File downloaded and saved to #{path}"
            end
        end
    end
end

download
