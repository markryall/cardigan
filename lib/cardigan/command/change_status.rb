module Cardigan
  module Command
    class ChangeStatus
      def initialize entry
        @entry = entry
      end

      def execute status
        @entry['status'] = status
      end
    end
  end
end