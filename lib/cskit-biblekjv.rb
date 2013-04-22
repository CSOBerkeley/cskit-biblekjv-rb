# encoding: UTF-8

module CSKitBibleKJV
  def self.resource_dir
    @resource_dir ||= File.join(File.dirname(File.dirname(__FILE__)), "resources")
  end
end