require 'cardigan/io'
require 'cardigan/root_context'
require 'flat_hash/serialiser'
require 'flat_hash/repository'
require 'cardigan/repository'
require 'cardigan/workflow_repository'

module Cardigan
  class Cli
    CONFIG_FILE = '.cardigan'

    def initialize io=Io.new
      @io = io
      @home = Directory.new('~')
    end

    def execute *args
      if @home.has_file?(CONFIG_FILE)
        config = @home.load(CONFIG_FILE)
      else
        config = { :name => @io.ask('Enter your full name'),
          :email => @io.ask('Enter your email address')
        }
        @home.store CONFIG_FILE, config 
      end
      name = "\"#{config[:name]}\" <#{config[:email]}>"
      RootContext.new(@io, FlatHash::Repository.new(FlatHash::Serialiser.new,'.cards'), name, WorkflowRepository.new('.')).push
    end
  end
end