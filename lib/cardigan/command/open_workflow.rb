require 'cardigan/workflow_context'

module Cardigan
  module Command
    class OpenWorkflow
      def initialize workflow_repository, io
        @workflow_repository, @io = workflow_repository, io
      end

      def execute name
        workflow = @workflow_repository.load
        WorkflowContext.new(@io, workflow).push
        @workflow_repository.save workflow
      end
    end
  end
end