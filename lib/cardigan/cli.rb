require 'cardigan/io'
require 'cardigan/root_context'
require 'flat_hash/directory'
require 'flat_hash/serialiser'
require 'flat_hash/repository'
require 'cardigan/workflow_repository'

class Cardigan::Cli
  CONFIG_FILE = '.cardigan'

  def initialize io=Cardigan::Io.new
    @io = io
    @home = FlatHash::Directory.new(FlatHash::Serialiser.new,File.expand_path('~'))
  end

  def execute *args
    config = @home.exist?(CONFIG_FILE) ? @home[CONFIG_FILE] : {}
    config['name'] = @io.ask('Enter your full name') unless config['name']
    config['email'] = @io.ask('Enter your email address') unless config['email']
    @home[CONFIG_FILE] = config
    repository = FlatHash::Repository.new(FlatHash::Serialiser.new,'.cards')
    name = "\"#{config['name']}\" <#{config['email']}>"
    workflow_repository = Cardigan::WorkflowRepository.new '.'
    root = Cardigan::RootContext.new @io, repository, name, workflow_repository
    if args.size == 0
      root.push
    else
      root.execute args
    end
  end
end