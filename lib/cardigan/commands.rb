module Cardigan
  module Command
    def self.load name, *args
      require "cardigan/command/#{name}"
      Command.const_get(classify name).new(*args)
    end

    def self.classify s
      s.to_s.split('_').map(&:capitalize).join
    end
  end
end