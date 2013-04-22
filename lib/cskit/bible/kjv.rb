# encoding: UTF-8

require 'cskit'
require 'cskit-biblekjv'

CSKit.register_book({
  :type => :bible,
  :id => :bible_kjv,
  :name => "The Holy Bible, King James Version",
  :author => "",
  :language => "English",
  :resource_path => File.join(CSKitBibleKJV.resource_dir, "bible", "kjv"),
  :parser => CSKit::Parsers::BibleParser,
  :reader => CSKit::Readers::BibleReader,
})