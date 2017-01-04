# encoding: UTF-8

require 'json'

module CSKit
  module Bible
    module Kjv
      class Volume < CSKit::Volume

        def get_book(book_name)
          if File.directory?(book_resource_path(book_name))
            glob_path = File.join(book_resource_path, '**')

            chapters = Dir.glob(glob_path).map.with_index do |resource_file, index|
              get_chapter(index + 1, book_name)
            end

            CSKit::Volumes::Bible::Book.new(book_name, chapters)
          end
        end

        def get_chapter(chapter_number, book_name)
          resource_file = File.join(book_resource_path(book_name), "#{chapter_number}.json")
          chapter_cache[resource_file] ||= CSKit::Volumes::Bible::Chapter.from_hash(
            JSON.parse(File.read(resource_file))
          )
        end

        def unabbreviate_book_name(orig_book_name)
          book_name = orig_book_name.strip.chomp('.')  # remove trailing period
          regex = /^#{book_name}\w*/i

          found_book = books.find do |book|
            book['name'] =~ regex
          end

          found_book ? found_book['name'] : orig_book_name
        end

        def books
          @books ||= JSON.parse(File.read(File.join(resource_path, 'books.json')))
        end

        private

        def book_resource_path(book_name)
          File.join(resource_path, book_name)
        end

        def chapter_cache
          @chapter_cache ||= {}
        end

      end
    end
  end
end
