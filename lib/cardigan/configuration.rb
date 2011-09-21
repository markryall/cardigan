module Cardigan
  class Configuration
    def initialize directory, name
      @directory = directory
      @name = name
      @config = @directory.exist?(name) ? @directory[name] : {}
    end

    def [] key
      @config[key]
    end

    def []= key, value
      @config[key] = value
      @directory[@name] = @config
    end
  end
end