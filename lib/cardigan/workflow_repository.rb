require 'flat_hash/serialiser'
require 'flat_hash/repository'

module Cardigan; end

class Cardigan::WorkflowRepository
  def initialize directory
    @directory = directory
    @key = '.card_workflow'
  end

  def save workflow
    workflow.keys.each do |key|
      workflow[key] = workflow[key].join("\n")
    end
    @directory[@key] = workflow
  end

  def load
    workflow = @directory.exist?(@key) ? @directory[@key] : {}
    workflow.keys.each do |key|
      workflow[key] = workflow[key].split("\n") unless workflow[key].instance_of?(Array)
    end
    workflow
  end
end