require 'rubygems'
require 'uuidtools'
require 'cardigan/context'
require 'cardigan/entry_context'

module Cardigan
  class RootContext
    include Context

    def initialize io, directory
      @io, @directory = io, directory
      @directory.create
      @prompt_text = 'cardigan > '
      @commands = ['edit']
    end

    def edit_command text
      entry = { :id => UUIDTools::UUID.random_create.to_s,
        :name => text
      }
      EntryContext.new(@io, entry).push
      @directory.store entry[:id], entry
    end
  end
end
    