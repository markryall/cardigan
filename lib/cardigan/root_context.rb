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
    end
    
    def refresh_commands
      @cards = @directory.find('*.card')
      @commands = ['edit', 'list']
      @cards.each do |card|
        @commands << "edit #{card[:name]}"
      end
    end

    def edit_command text
      card = @cards.find {|card| card[:name] == text}
      card ||= { :id => UUIDTools::UUID.random_create.to_s,
        :name => text
      }
      EntryContext.new(@io, card).push
      @directory.store "#{card[:id]}.card", card
    end

    def list_command text=nil
      cards = text ? @cards.select {|card| eval text } : @cards
      @io.say "\n#{cards.count} cards"
      cards.map {|card| card[:name] }.sort.each {|name| @io.say name }
    end
  end
end
    