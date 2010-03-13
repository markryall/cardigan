module Cardigan
  module Command
    class CreateCard
      def initialize repository
        @repository = repository
      end

      def execute name
        @repository.save @repository.find_or_create(name)
      end
    end
  end
end