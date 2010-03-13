module Cardigan
  module Command
    class BatchUpdateCards
      def initialize repository, io
        @repository, @io = repository, io
      end

      def execute text
        key, *rest = text.scan(/\w+/)
        value = @io.ask("Enter the new value for #{key}")
        @repository.each_card_from_indices(rest.join(' ')) do |card|
          if value.empty?
            @io.say "removing #{key} from '#{card['name']}'"
            card.delete key
          else
            @io.say "setting #{key} to '#{value}' for '#{card['name']}'"
            card[key] = value
          end
          @repository.save card
        end
      end
    end
  end
end