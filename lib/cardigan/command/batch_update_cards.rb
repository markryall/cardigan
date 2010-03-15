require 'cardigan/card_editor'

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
          Cardigan::CardEditor.new(card, @io).set key, value
          @repository.save card
        end
      end
    end
  end
end