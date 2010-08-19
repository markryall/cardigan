require 'flat_hash/serialiser'
require 'flat_hash/repository'

module Cardigan
  class WorkflowRepository
    def initialize path
      @repository = FlatHash::Repository.new(FlatHash::Serialiser.new,'.')
      @directory = Directory.new(path)
      @key = '.card_workflow'
    end

    def save workflow
      @directory[@path] = workflow
    end

    def load
      @directory[@path]
    end
  end
end