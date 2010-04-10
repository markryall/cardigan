module Cardigan
  class TextReportFormatter
    INDEX_HEADING = 'index'
    
    def initialize io
      @io = io
      @columns = []
    end

    def add_column name, length
      longer = [name.length, length].max
      @columns << [name, longer]
    end

    def output hashes, options={}
      return if @columns.empty?
      width = calculate_width(options[:suppress_index])
      hline width
      row INDEX_HEADING, @columns.map {|tuple| tuple.first }, options[:suppress_index]
      hline width
      hashes.each_with_index do |h,i|
        row (i+1).to_s, @columns.map {|tuple| h[tuple.first]}, options[:suppress_index]
      end
      hline width
    end
private
    def hline width
      @io.say ' ' + '-' * (width - 2)
    end

    def calculate_width suppress_index
      width = suppress_index ? 1 : INDEX_HEADING.length + 4
      @columns.each {|column| width += column[1] + 3}
      width
    end

    def row first, values, suppress_index
      a = suppress_index ? "|" : "| #{first.ljust(INDEX_HEADING.length)} |"      
      @columns.each_with_index do |tuple, index|
        a << " #{values[index].to_s.ljust(tuple[1])} |"
      end
      @io.say a
    end
  end
end