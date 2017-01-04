# encoding: UTF-8

require 'bundler'
require 'digest'

require 'rubygems/package_task'

require 'cskit/bible/kjv'

Bundler::GemHelper.install_tasks

task :update do
  input_file = File.join(File.dirname(__FILE__), 'vendor', 'biblekjv.txt')
  output_dir = CSKit::Bible::Kjv.resource_root
  splitter = CSKit::Bible::Kjv::Splitter.new(input_file)

  FileUtils.mkdir_p(output_dir)

  splitter.each_chapter do |chapter, book|
    book_name = book.name.downcase.gsub(' ', '_')
    book_output_dir = File.join(output_dir, book_name)
    FileUtils.mkdir_p(book_output_dir)

    File.open(File.join(book_output_dir, "#{chapter.number}.json"), 'w+') do |f|
      puts "Writing #{book.name}, chapter #{chapter.number} ..."
      f.write(chapter.to_hash.to_json)
    end
  end
end
