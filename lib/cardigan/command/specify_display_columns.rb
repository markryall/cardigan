module Cardigan
  module Command
    class SpecifyDisplayColumns
      def initialize repository, io
        @repository, @io = repository, io
      end

      def execute text
        if text
          @repository.display_columns = text.scan(/\w+/) 
        else
          @io.say "current columns: #{@repository.display_columns.join(',')}"
          columns = Set.new
          @repository.cards.each {|card| columns += card.keys }
          @io.say "available columns: #{columns.sort.join(',')}"
        end
      end
    end
  end
end