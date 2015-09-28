#!/usr/bin/env ruby

require 'pry'
require 'capybara'
require_relative '../lib/list_files_by_mtime'

#Capybara configuration
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
Capybara.default_driver = :chrome
Capybara.default_max_wait_time = 40
include Capybara::DSL

# Args parsing
user_name = ARGV[0]
password = ARGV[1]
directory_path = ARGV[2]

# notes fetching
notes = ListFilesByMtime.call(directory_path)
# DELETE ME WHEN GO TIME
notes = [notes.first]

# logging in
visit "https://icloud.com"
find('input[aria-label="Apple ID"]').send_keys(user_name)
find('input[aria-label="Password"]').send_keys(password + "\n")

# open notes
sleep 2
find('a[href="#notes"]').click

notes.each do |note|
  #create a note
  sleep 2
  within_frame('notes') do
    find('.newnote-button').click

    #paste in the note
    within_frame(find('.mceIframeContainer iframe')) do
      find('body').send_keys(note)
    end
  end

end

binding.pry
