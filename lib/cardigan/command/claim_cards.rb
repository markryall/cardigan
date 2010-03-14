module Cardigan
  module Command
    class ClaimCards
      def initialize repository, io, name
        @repository, @io, @name = repository, io, name
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