require 'rubygems'
require 'uuidtools'
require 'cardigan/context'
require 'cardigan/entry_context'

module Cardigan
  class RootContext
    include Context

    def initialize io, repository, name
      @io, @repository, @name = io, repository, name
      @prompt_text = 'cardigan > '
    end

    def refresh_commands
      @repository.refresh
      @commands = ['edit', 'list']
      @repository.cards.each do |card|
        @commands << "edit #{card['name']}"
        if card['owner'] == @name
          @commands << "unclaim #{card['name']}"
        else
          @commands << "claim #{card['name']}"
        end
      end
    end

    def edit_command text
      card = @repository.find_card(name)
      card ||= { 'id' => UUIDTools::UUID.random_create.to_s,
        'name' => text
      }
      EntryContext.new(@io, card).push
      @repository.save card
    end

    def list_command text=nil
      cards = text ? @repository.cards.select {|card| eval text } : @repository.cards
      @io.say "\n#{cards.count} cards"
      cards.map {|card| card['name'] }.sort.each {|name| @io.say name }
    end
    
    def claim_command name
      set_key name, 'owner', @name
    end
    
    def unclaim_command name
      set_key name, 'owner', nil
    end
private
    def set_key name, key, value
      card = @repository.find_card(name)
      if card
        card[key] = value
        @repository.save card
      else
        @io.say "unknown card #{text}"
      end
    end
  end
end
    