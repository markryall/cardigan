module Cardigan
  class Io
    def initialize in_io=$stdin, out_io=$stdout
      @in_io, @out_io = in_io, out_io
    end

    def ask prompt
      @out_io.print "#{prompt} > "
      @in_io.gets.chomp
    end
  end
end