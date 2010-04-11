module Cardigan
  module Command
    class ChangeStatus
      def initialize entry, workflow_repository
        @entry = entry
      end

      def execute status
        @entry['status'] = status
      end
      
      def completion
        status = @entry['status'] || 'none'
        next_statuses = @workflow_repository.load[status]
        next_statuses ? next_statuses.map { |s| "now #{s}" } : []
      end
    end
  end
end