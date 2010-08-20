require 'flat_hash/serialiser'
require 'flat_hash/repository'

class Cardigan::WorkflowRepository
  def initialize path
    @directory = FlatHash::Directory.new(FlatHash::Serialiser.new,'.')
    @key = '.card_workflow'
  end

  def save workflow
    @directory[@key] = workflow
  end

  def load
    @directory[@key]
  end
end