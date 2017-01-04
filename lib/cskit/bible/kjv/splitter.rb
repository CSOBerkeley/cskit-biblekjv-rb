# encoding: UTF-8

require 'json'

module CSKit
  module Bible
    module Kjv

      # Splits the kjv bible text (from Project Gutenberg) in the vendor directory.
      # Mainly designed to be used by the 'update' rake task.
      class Splitter

        VERSE_REGEX = /\d{1,3}:\d{1,3}/
        BOOK_TRIGGERS = [
          'Jonah',
          'The Epistle of Paul the Apostle to the Hebrews',
          'The Third Epistle General of John',
          'The General Epistle of Jude',
          'The Revelation of Saint John the Devine'
        ]

        include Enumerable
        attr_reader :input_file

        def initialize(input_file)
          @input_file = input_file
        end

        def each
          verse_buffer = ''
          chapter = CSKit::Volumes::Bible::Chapter.new(1, [])
          book = CSKit::Volumes::Bible::Book.new(book_data.first['name'], [chapter])
          book_count = 1

          File.open(input_file).each_line do |line|
            if line.strip.empty?
              if verse_buffer =~ /\A#{VERSE_REGEX}/
                split_verses(verse_buffer).each do |verse_data|
                  chapter_num, verse_num, text = verse_data

                  if chapter_num != chapter.number
                    yield chapter, book
                    new_chapter = CSKit::Volumes::Bible::Chapter.new(chapter_num, [])
                  end

                  if chapter_num > chapter.number
                    book.chapters << new_chapter
                    chapter = new_chapter
                  elsif chapter_num != chapter.number
                    book = CSKit::Volumes::Bible::Book.new(book_data[book_count]['name'], [new_chapter])
                    book_count += 1
                    chapter = new_chapter
                  end

                  chapter.verses << CSKit::Volumes::Bible::Verse.new(text.strip)
                end
              end

              verse_buffer.clear
            elsif
              # Jonah (and Hebrews) is special because Obadiah (the book before Jonah)
              # only has one chapter and therefore breaks the assumption that all
              # books have more than one chapter, which this script uses to avoid
              # having to identify book headers. Yes, it's ugly.
              if BOOK_TRIGGERS.include?(line.strip)
                yield chapter, book
                chapter = CSKit::Volumes::Bible::Chapter.new(1, [])
                book = CSKit::Volumes::Bible::Book.new(book_data[book_count]['name'], [chapter])
                book_count += 1
              end
            else
              verse_buffer << "#{line.strip} "
            end
          end

          yield chapter, book
        end

        alias_method :each_chapter, :each

        private

        def book_data
          @book_data ||= JSON.parse(
            File.read(
              File.join(CSKit::Bible::Kjv.resource_root, 'books.json')
            )
          )
        end

        def split_verses(text)
          verses = text.split(/(#{VERSE_REGEX})/)
          verses[1..-1].each_slice(2).map do |verse_parts|
            verse_parts.first.split(":").map(&:to_i) + [verse_parts.last]
          end
        end

      end
    end
  end
end
