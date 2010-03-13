module Cardigan
  module Command
    class DestroyCards
      def initialize repository, io
        @repository, @io = repository, io
      end

      def execute numbers
        @repository.each_card_from_indices(numbers) do |card|
          @io.say "destroying \"#{card['name']}\""
          @repository.destroy card
        end
      end
    end
  end
end