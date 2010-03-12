require 'rubygems'
require 'uuidtools'
require 'cardigan/context'
require 'cardigan/entry_context'
require 'cardigan/text_report_formatter'

module Cardigan
  class RootContext
    include Context

    def initialize io, repository, name
      @io, @repository, @name = io, repository, name
      @prompt_text = "#{File.expand_path('.').split('/').last} > "
    end

    def refresh_commands
      @repository.refresh
      @commands = ['create', 'list', 'filter', 'unfilter']
      @repository.cards.each do |card|
        @commands << "open #{card['name']}"
        @commands << "destroy #{card['name']}"
        if card['owner'] == @name
          @commands << "unclaim #{card['name']}"
        else
          @commands << "claim #{card['name']}"
        end
      end
    end

    def create_command name
      @repository.save @repository.find_or_create(name)
    end

    def open_command text
      card = @repository.find_or_create(name)
      EntryContext.new(@io, card).push
      @repository.save card
    end

    def destroy_command text
      cards = sorted_selection
      text.scan(/\d+/).each do |n|
        card = cards[n.to_i - 1]
        @io.say "destroying \"#{card['name']}\""
        @repository.destroy card
      end
    end

    def list_command ignored
      cards = sorted_selection
      formatter = TextReportFormatter.new @io
      a = 0
      formatter.add_column('name', max_field_length(cards, 'name'))
      formatter.output cards
    end
    
    def unfilter_command ignored
      @filter = nil
    end
    
    def filter_command code
      @filter = code
      begin
        cards = @repository.cards.select {|card| eval @filter }
        @io.say "#{cards.count} cards match filter"
      rescue Exception => e
        @io.say "Invalid expression:\n#{e.message}"
        @filter = nil
      end
    end
    
    def claim_command name
      set_key name, 'owner', @name
    end
    
    def unclaim_command name
      set_key name, 'owner', nil
    end
private
    def max_field_length cards, name
      cards.map {|v| v[name] ? v[name].length : 0 }.max
    end

    def sorted_selection
      cards = @filter ? @repository.cards.select {|card| eval @filter } : @repository.cards
      cards.sort {|a,b| a['name'] <=> b['name'] }
    end

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
    