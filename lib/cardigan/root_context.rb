require 'rubygems'
require 'uuidtools'
require 'cardigan/context'
require 'cardigan/entry_context'

module Cardigan
  class RootContext
    include Context

    def initialize io, directory, name
      @io, @directory, @name = io, directory, name
      @directory.create
      @prompt_text = 'cardigan > '
    end

    def refresh_commands
      @cards = @directory.find('*.card')
      @commands = ['edit', 'list']
      @cards.each do |card|
        @commands << "edit #{card['name']}"
        if card['owner'] == @name
          @commands << "unclaim #{card['name']}"
        else
          @commands << "claim #{card['name']}"
        end
      end
    end

    def edit_command text
      card = @cards.find {|card| card['name'] == text}
      card ||= { 'id' => UUIDTools::UUID.random_create.to_s,
        'name' => text
      }
      EntryContext.new(@io, card).push
      save card
    end

    def list_command text=nil
      cards = text ? @cards.select {|card| eval text } : @cards
      @io.say "\n#{cards.count} cards"
      cards.map {|card| card['name'] }.sort.each {|name| @io.say name }
    end
    
    def claim_command text
      card = @cards.find {|card| card['name'] == text}
      if card
        card['owner'] = @name
        save card
      else
        @io.say "unknown card #{text}"
      end
    end
    
    def unclaim_command text
      card = @cards.find {|card| card['name'] == text}
      if card
        card['owner'] = nil
        save card
      else
        @io.say "unknown card #{text}"
      end
    end
private
    def save card
      @directory.store "#{card['id']}.card", card
    end
  end
end
    