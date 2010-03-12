module Cardigan
  class TextReportFormatter
    def initialize io
      @io = io
      @columns = []
      @heading = 'index'
      @width = 2 + @heading.length + 1
    end

    def add_column name, length
      longer = [name.length, length].max
      @columns << [name, longer]
      @width += longer + 3
    end

    def output hashes
      hline
      row 'index', @columns.map {|tuple| tuple.first }
      hline
      hashes.each_with_index do |h,i|
        row i.to_s, @columns.map {|tuple| h[tuple.first]}
      end
      hline
    end
private
    def hline
      @io.say ' ' + '-' * @width
    end
    
    def row first, values
      a = "| #{first.ljust(@heading.length)} | "      
      @columns.each_with_index do |tuple, index|
        a << " #{values[index].to_s.ljust(tuple[1])} |"
      end
      @io.say a
    end
  end
end