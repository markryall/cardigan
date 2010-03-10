require 'yaml'
require 'fileutils'

module Cardigan
  class Directory
    def initialize path
      @path = File.expand_path(path)
    end

    def has_file? file
      File.exist? File.join(@path, file)
    end

    def load file
      YAML::load File.read(File.join(@path, file))
    end

    def store file, hash
      File.open(File.join(@path, file), 'w') {|f| f.print hash.to_yaml}
    end
    
    def create
      FileUtils.mkdir_p @path
    end
    
    def find pattern
      Dir.glob(File.join(@path, pattern)).map {|path| YAML::load File.read(path) }
    end
  end
end