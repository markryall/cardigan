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
      @columns = ['name']
    end

    def refresh_commands
      @repository.refresh
      @commands = ['create', 'list', 'filter', 'unfilter', 'columns', 'claim', 'unclaim', 'destroy']
      @repository.cards.each do |card|
        @commands << "open #{card['name']}"
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

    def destroy_command numbers
      each_card_from_indices(numbers) do |card|
        @io.say "destroying \"#{card['name']}\""
        @repository.destroy card
      end
    end

    def list_command ignored
      cards = sorted_selection
      formatter = TextReportFormatter.new @io
      a = 0
      @columns.each do |column|
        formatter.add_column(column, max_field_length(cards, column))
      end
      formatter.output cards
    end
    
    def unfilter_command ignored
      @filter = nil
    end
    
    def columns_command text
      @columns = text.scan(/\w+/) if text
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
    
    def claim_command numbers
      each_card_from_indices(numbers) do |card|
        @io.say "claiming \"#{card['name']}\""
        card['owner'] = @name
        @repository.save card
      end
    end
    
    def unclaim_command numbers
      each_card_from_indices(numbers) do |card|
        @io.say "claiming \"#{card['name']}\""
        card.delete('owner')
        @repository.save card
      end
    end
private
    def each_card_from_indices numbers
      cards = sorted_selection
      numbers.scan(/\d+/).each do |n|
        yield cards[n.to_i - 1]
      end
    end

    def max_field_length cards, name
      cards.map {|card| card[name] ? card[name].length : 0 }.max
    end
 
    def sorted_selection
      cards = @filter ? @repository.cards.select {|card| eval @filter } : @repository.cards
      cards.sort {|a,b| a['name'] <=> b['name'] }
    end
  end
end
