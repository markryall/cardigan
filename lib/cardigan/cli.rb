require 'cardigan/io'
require 'cardigan/root_context'
require 'flat_hash/directory'
require 'flat_hash/serialiser'
require 'flat_hash/repository'
require 'cardigan/workflow_repository'
require 'cardigan/configuration'
require 'cardigan/filtered_repository'

class Cardigan::Cli
  def initialize io=Cardigan::Io.new
    @io = io
    home_path = File.expand_path '~'
    home = FlatHash::Directory.new FlatHash::Serialiser.new, home_path
    @local = FlatHash::Directory.new FlatHash::Serialiser.new, '.'
    @configuration = Cardigan::Configuration.new home, '.cardigan'
  end

  def execute *args
    @configuration['name'] = @io.ask('Enter your full name') unless @configuration['name']
    @configuration['email'] = @io.ask('Enter your email address') unless @configuration['email']
    repository = FlatHash::Repository.new FlatHash::Serialiser.new, '.cards'
    name = "\"#{@configuration['name']}\" <#{@configuration['email']}>"
    local_configuration = Cardigan::Configuration.new @local, '.cardigan'
    filtered_repository = Cardigan::FilteredRepository.new repository, name, local_configuration
    workflow_repository = Cardigan::WorkflowRepository.new @local
    root = Cardigan::RootContext.new @io, filtered_repository, name, workflow_repository
    if args.size == 0
      root.push
    else
      root.execute args
    end
  end
end