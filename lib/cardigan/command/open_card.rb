require 'cardigan/entry_context'
require 'uuidtools'

class Cardigan::Command::OpenCard
  attr_reader :usage, :help

  def initialize repository, workflow_repository, io
    @repository, @workflow_repository, @io = repository, workflow_repository, io
    @usage = '<card name>'
    @help = 'Opens the specified card for editing'
  end

  def execute name
    entry = @repository.cards.find { |entry| entry['name'] == name }
    id = entry ? entry.id : UUIDTools::UUID.random_create.to_s
    entry ||= {'name' => name, 'id' => id}
    original = entry.dup
    Cardigan::EntryContext.new(@io, @workflow_repository, entry).push
    @repository[id] = entry unless original == entry
  end

  def completion text
    @repository.cards.map {|card| card['name'] }.grep(/^#{Regexp.escape(text)}/).sort
  end
end