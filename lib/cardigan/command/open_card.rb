require 'cardigan/entry_context'

module Cardigan
  module Command
    class OpenCard
      def initialize repository
        @repository = repository
      end

      def execute name
        card = @repository.find_or_create(name)
        EntryContext.new(@io, card).push
        @repository.save card
      end
    end
  end
end