require 'cardigan/root_context'

module Cardigan
  class Cli
    def initialize in_io=$stdin, out_io=$stdout
      @in_io, @out_io = in_io, out_io
    end

    def execute *args
      consume_args *args
      RootContext.new.push
    end
private
    def consume_args *args
    end
  end
end