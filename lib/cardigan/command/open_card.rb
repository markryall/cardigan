require 'cardigan/entry_context'

module Cardigan
  module Command
    class OpenCard
      def initialize repository, workflow_repository, io
        @repository, @workflow_repository, @io = repository, workflow_repository, io
      end

      def execute name
        card = @repository.find_or_create(name)
        EntryContext.new(@io, @workflow_repository, card).push
        @repository.save card
      end
    end
  end
end