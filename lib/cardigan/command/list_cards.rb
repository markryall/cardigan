require 'cardigan/text_report_formatter'

module Cardigan
  module Command
    class ListCards
      def initialize repository, io
        @repository, @io = repository, io
      end

      def execute text
        cards = @repository.cards
        formatter = TextReportFormatter.new @io
        @repository.display_columns.each do |column|
          formatter.add_column(column, @repository.max_field_length(column))
        end
        formatter.output cards
      end
    end
  end
end