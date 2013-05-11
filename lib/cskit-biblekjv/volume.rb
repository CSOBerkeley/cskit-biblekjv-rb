# encoding: UTF-8

require 'json'

module CSKitBibleKJV
  class Volume < CSKit::Volume

    def get_book(book_name)
      if File.directory?(book_resource_path(book_name))
        CSKit::Volumes::Bible::Book.new(book_name, Dir.glob(File.join(book_resource_path, "**")).map.with_index do |resource_file, index|
          get_chapter(index + 1, book_name)
        end)
      else
        nil
      end
    end

    def get_chapter(chapter_number, book_name)
      resource_file = File.join(book_resource_path(book_name), "#{chapter_number}.json")
      chapter_cache[resource_file] ||= CSKit::Volumes::Bible::Chapter.from_hash(JSON.parse(File.read(resource_file)))
    end

    def books
      @books ||= JSON.parse(File.read(File.join(resource_path, "books.json")))
    end

    protected

    def book_resource_path(book_name)
      File.join(resource_path, book_name)
    end

    def chapter_cache
      @chapter_cache ||= {}
    end

  end
end