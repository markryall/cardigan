module Cardigan
  module Command
    class SelectColumns
      def initialize repository, io
        @repository, @io = repository, io
      end

      def execute text
        if text
          @repository.columns = text.scan(/\w+/) 
        else
          @io.say "current columns: #{@repository.columns.join(',')}"
          columns = Set.new
          @repository.cards.each {|card| columns += card.keys }
          @io.say "available columns: #{columns.sort.join(',')}"
        end
      end
    end
  end
end