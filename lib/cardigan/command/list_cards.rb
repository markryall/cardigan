require 'cardigan/text_report_formatter'

module Cardigan
  module Command
    class ListCards
      def initialize repository, io, columns
        @repository, @io, @columns = repository, io, columns
      end

      def execute name
        cards = @repository.cards
        formatter = TextReportFormatter.new @io
        a = 0
        @columns.each do |column|
          formatter.add_column(column, @repository.max_field_length(column))
        end
        formatter.output cards
      end
    end
  end
end