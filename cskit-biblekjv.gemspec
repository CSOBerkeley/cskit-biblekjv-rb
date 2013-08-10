# encoding: UTF-8

$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'cskit-biblekjv/version'

Gem::Specification.new do |s|
  s.name     = "cskit-biblekjv"
  s.version  = ::CSKitBibleKJV::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["camertron@gmail.com"]
  s.homepage = "http://github.com/camertron"

  s.description = s.summary = "Bible resources for CSKit, King James Version."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.add_dependency 'json'
  s.add_dependency 'cskit', '~> 1.0.0'

  s.add_development_dependency 'rake'

  s.require_path = 'lib'
  s.files = Dir["{lib,spec,resources}/**/*", "Gemfile", "History.txt", "LICENSE", "README.md", "Rakefile", "cskit-biblekjv.gemspec"]
end
