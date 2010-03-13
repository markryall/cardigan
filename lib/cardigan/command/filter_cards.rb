module Cardigan
  module Command
    class FilterCards
      def initialize repository, io
        @repository, @io = repository, io
      end

      def execute filter
        @repository.filter = filter
        begin
          @io.say "#{@repository.cards.length} cards match filter"
        rescue Exception => e
          @io.say "Invalid expression:\n#{e.message}"
          @repository.filter = nil
        end
      end
    end
  end
end