require 'cardigan/io'
require 'cardigan/root_context'
require 'cardigan/directory'

module Cardigan
  class Cli
    def initialize io=Io.new
      @io = io
      @home = Directory.new('~')
    end

    def execute *args
      unless @home.has_file?('.cardigan')
        name = @io.ask('Enter your full name')
        email = @io.ask('Enter your email address')
        #File
      end
      #consume_args *args
      #RootContext.new.push
    end
private
    def consume_args *args
    end
  end
end