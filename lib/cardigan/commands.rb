require 'active_support/inflector'

module Cardigan
  module Command
    def self.load name, *args
      require "cardigan/command/#{name}"
      Command.const_get(name.to_s.camelize).new(*args)
    end
  end
end