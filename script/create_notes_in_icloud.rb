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
notes = ListFilesByMtime.call(directory_path).reject(&:empty?)

# logging in
visit "https://icloud.com"
find('input[aria-label="Apple ID"]').send_keys(user_name)
find('input[aria-label="Password"]').send_keys(password + "\n")

# open notes
sleep 2
find('a[href="#notes"]').click

notes.each_with_index do |note, i|
  sleep 2
  within_frame('notes') do
    puts "\n\n----------------\nCreating note ##{i + 1}"
    find('.newnote-button').click

    puts "Writing out note contents:\n\n#{note}"
    within_frame(find('.mceIframeContainer iframe')) do |frame|
      frame.execute_script("window.parent.tinymce.editors[0].setContent(\"#{note.gsub('"',%q(\\\")).gsub(/\n/,'<br/>')}\")")
      frame.execute_script("window.parent.tinyMCE.triggerSave()")
      find('body').send_keys('   ')
      sleep 1
      find('body').native.send_keys(:backspace, :backspace, :backspace)
    end
  end
end

# let icloud be the slowest syncing service we all know and love
puts "Finishing Sync. This is highly technical"
sleep 20

