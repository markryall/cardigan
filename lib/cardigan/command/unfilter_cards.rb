module Cardigan
  module Command
    class UnfilterCards
      def initialize repository
        @repository = repository
      end

      def execute ignored
        @repository.filter = nil
      end
    end
  end
end