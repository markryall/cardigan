require 'cardigan/commands'
require 'cardigan/workflow_context'

class Cardigan::Command::OpenWorkflow
  attr_reader :usage, :help

  def initialize workflow_repository, io
    @workflow_repository, @io = workflow_repository, io
    @usage = ''
    @help = 'Opens the current workflow for editing'
  end

  def execute name
    workflow = @workflow_repository.load
    original = workflow.dup
    Cardigan::WorkflowContext.new(@io, workflow).push
    @workflow_repository.save workflow unless workflow == original
  end
end