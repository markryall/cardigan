module Cardigan
  module Command
    class ClaimCards
      def initialize repository, io
        @repository, @io = repository, io
      end

      def execute numbers
        @repository.each_card_from_indices(numbers) do |card|
          @io.say "claiming \"#{card['name']}\""
          card['owner'] = @name
          @repository.save card
        end
      end
    end
  end
end