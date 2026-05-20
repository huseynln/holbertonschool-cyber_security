#!/usr/bin/env ruby

require 'digest'

def craker_pwd
    if ARGV.length != 2
        puts "Usage: 10-password_cracked.rb HASHED_PASSWORD DICTIONARY_FILE"
        exit
    end
    hashed_password = ARGV[0]
    dictionary_file = ARGV[1]
    found = false
    # abrir archivo de passwords
    File.foreach(dictionary_file) do |word|
        word = word.chomp
        # generar sha256 por cada word
        hashed_word = Digest::SHA256.hexdigest(word)
        # compararlo
        if hashed_word == hashed_password
            puts "Password found: #{word}"
            found = true
            break
        end
    end
    puts "Password not found in dictionary." unless found
end

craker_pwd
