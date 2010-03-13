module Cardigan
  module Command
    class UnclaimCards
      def initialize repository, io
        @repository, @io = repository, io
      end

      def execute numbers
        @repository.each_card_from_indices(numbers) do |card|
          @io.say "unclaiming \"#{card['name']}\""
          card.delete('owner')
          @repository.save card
        end
      end
    end
  end
end