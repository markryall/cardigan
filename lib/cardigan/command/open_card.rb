require 'cardigan/entry_context'

class Cardigan::Command::OpenCard
  attr_reader :usage, :help

  def initialize repository, workflow_repository, io
    @repository, @workflow_repository, @io = repository, workflow_repository, io
    @usage = '<card name>'
    @help = 'Opens the specified card for editing'
  end

  def execute name
    entry = @repository.find { |entry| entry['name'] == name }
    id = entry ? entry.id : UUIDTools::UUID.random_create.to_s
    entry ||= {'name' => name}
    original = entry.dup
    EntryContext.new(@io, @workflow_repository, entry).push
    @repository[id] = entry unless original == entry
  end

  def completion text
    @repository.map {|card| card['name'] }.grep(/^#{Regexp.escape(text)}/).sort
  end
end