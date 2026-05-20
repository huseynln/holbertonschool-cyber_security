require_relative '3-read_file'
require_relative '4-write_file'

file1_path = 'file_to_copy_from.json'
file2_path = 'file.json'


merge_json_files(file1_path, file2_path)


puts 'File merged successfully!'

count_user_ids(file2_path)
