module Cardigan
  module Command
    class ChangeStatus
      attr_reader :usage, :help

      def initialize entry, workflow_repository
        @entry, @workflow_repository = entry, workflow_repository
        @usage = '<new status>'
        @help = 'changes the status of the current entry'
      end

      def completion text
        status = @entry['status'] || 'none'
        @workflow_repository.load[status].grep(/^#{text}/).sort || []
      end

      def execute status
        @entry['status'] = status
      end
    end
  end
end