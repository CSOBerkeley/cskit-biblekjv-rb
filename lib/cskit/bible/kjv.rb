# encoding: UTF-8

require 'cskit'
require 'pathname'

module CSKit
  module Bible
    module Kjv
      autoload :Splitter, 'cskit/bible/kjv/splitter'
      autoload :Volume,   'cskit/bible/kjv/volume'

      class << self
        def resource_dir
          @resource_dir ||= resource_pathname.to_s
        end

        def resource_root
          @resource_root ||= resource_pathname.join('bible', 'kjv').to_s
        end

        private

        def resource_pathname
          @resource_dir ||= Pathname(__FILE__)
            .dirname.dirname.dirname.dirname
            .join('resources')
        end
      end
    end
  end
end

CSKit.register_volume({
  type: :bible,
  id: :bible_kjv,
  name: 'The Holy Bible, King James Version',
  author: '',
  language: 'English',
  resource_path: CSKit::Bible::Kjv.resource_root,
  volume: CSKit::Bible::Kjv::Volume,
  parser: CSKit::Parsers::Bible::BibleParser,
  reader: CSKit::Readers::BibleReader
})
