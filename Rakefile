# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'rubygems' unless ENV['NO_RUBYGEMS']

require 'bundler'
require 'digest'

require 'rubygems/package_task'

require './lib/cskit-biblekjv'

Bundler::GemHelper.install_tasks

task :update do
  require 'cskit'
  require 'cskit-biblekjv/bible_splitter'

  input_file = File.join(File.dirname(__FILE__), "vendor/biblekjv.txt")
  output_dir = File.join(File.dirname(__FILE__), "resources/bible/kjv")
  splitter = CSKit::Splitters::BibleSplitter.new(input_file)

  FileUtils.mkdir_p(output_dir)

  splitter.each_chapter do |chapter, book|
    book_name = book.name.downcase.gsub(" ", "_")
    book_output_dir = File.join(output_dir, book_name)
    FileUtils.mkdir_p(book_output_dir)

    File.open(File.join(book_output_dir, "#{chapter.number}.json"), "w+") do |f|
      puts "Writing #{book.name}, chapter #{chapter.number} ..."
      f.write(chapter.to_hash.to_json)
    end
  end
end
