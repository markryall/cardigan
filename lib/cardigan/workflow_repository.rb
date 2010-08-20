require 'flat_hash/serialiser'
require 'flat_hash/repository'

class Cardigan::WorkflowRepository
  def initialize path
    @directory = FlatHash::Directory.new(FlatHash::Serialiser.new,'.')
    @key = '.card_workflow'
  end

  def save workflow
    workflow.keys.each do |key|
      workflow[key] = workflow[key].join("\n")
    end
    @directory[@key] = workflow
  end

  def load
    workflow = @directory[@key]
    workflow.keys.each do |key|
      workflow[key] = workflow[key].split("\n") unless workflow[key].instance_of?(Array)
    end
    workflow
  end
end