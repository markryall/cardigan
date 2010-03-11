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
      card = find_card(name)
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
      set_key name, 'owner', @name
    end
    
    def unclaim_command text
      set_key name, 'owner', nil
    end
private
    def find_card name
      @cards.find {|card| card['name'] == name}
    end

    def set_key name, key, value
      card = find_card(name)
      if card
        card[key] = value
        save card
      else
        @io.say "unknown card #{text}"
      end
    end

    def save card
      @directory.store "#{card['id']}.card", card
    end
  end
end
    