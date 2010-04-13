require 'cardigan/card_editor'

module Cardigan
  module Command
    class BatchUpdateCards
      attr_reader :usage, :help

      def initialize repository, io
        @repository, @io = repository, io
        @usage = '<field> [<index>]+'
        @help = 'prompts for a new value for the specified field for the entries at the specified index'
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