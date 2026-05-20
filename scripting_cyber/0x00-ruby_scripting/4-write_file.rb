#!/usr/bin/env ruby
require 'json'

def merge_json_files(file1_path, file2_path)
    file_content_1 = File.read(file1_path)
    file_content_2 = File.read(file2_path)

    data1 = JSON.parse(file_content_1)
    data2 = JSON.parse(file_content_2)

    merge_data = data2.concat(data1)

    File.open(file2_path, "w") do |f|
        f.write(JSON.pretty_generate(merge_data))
        puts "Merged JSON written to file.json"
    end
end
