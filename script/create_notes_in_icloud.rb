#!/usr/bin/env ruby

require 'capybara'
require_relative '../lib/list_files_by_mtime'

directory_path = ARGV[0]

notes = ListFilesByMtime.call(directory_path)

puts notes
