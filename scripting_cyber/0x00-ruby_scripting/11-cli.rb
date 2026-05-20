#!/usr/bin/env ruby

require 'optparse'

# file to store tasks
TASK_FILE = 'tasks.txt'

# method to read tasks from the file
def read_tasks
    if File.exists?(TASK_FILE)
        File.readlines(TASK_FILE).map(&:chomp)
    else
        []
    end
end

# methods to save tasks to the file
def save_tasks(tasks)
    tasks.uniq!
    File.open(TASK_FILE, 'w') do |file|
        tasks.each { |task| file.puts(task) }
    end
end

# Command-line options
options = {}
OptionParser.new do |opts|
    opts.banner = "Usage: cli.rb [options]"

    opts.on("-a", "--add TASK", "Add a new task") do |task|
        options[:add] = task
    end

    opts.on("-l", "--list", "List all tasks") do
        options[:list] = true
    end

    opts.on("-r", "--remove INDEX", "Remove a task by index") do |index|
        options[:remove] = index.to_i
    end

    opts.on("-h", "--help", "Show help") do
        puts opts
        exit
    end
end.parse!

# main aplication logic
if options[:add]
    tasks = read_tasks
    tasks << options[:add]
    save_tasks(tasks)
    puts "Task '#{options[:add]}' added."

# List tasks
elsif options[:list]
    tasks = read_tasks
    if tasks.empty?
        puts "No tasks available"
    else
        puts "Tasks:"
        tasks.each_with_index do |task, index|
            puts "#{index + 1}. #{task}"
        end
    end

# Remove task
elsif options[:remove]
    tasks = read_tasks
    if options[:remove] > 0 && options[:remove] <= tasks.length
        removed_task = tasks.delete_at(options[:remove] - 1)
        save_tasks(tasks)
        puts "Task '#{removed_task}' removed."
    else
        puts "Invalid index."
    end
end
