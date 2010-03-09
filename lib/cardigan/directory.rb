puts 'loading directory'

module Cardigan
  class Directory
    def initialize path
      @path = File.expand_path(path)
    end
    
    def has_file? file
      File.exist? File.join(@path, file)
    end
  end
end