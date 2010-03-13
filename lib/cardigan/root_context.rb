require 'rubygems'
require 'uuidtools'
require 'set'
require 'cardigan/context'
require 'cardigan/entry_context'
require 'cardigan/text_report_formatter'
require 'cardigan/filtered_repository'

module Cardigan
  class RootContext
    include Context

    def initialize io, repository, name
      @io, @repository, @name = io, FilteredRepository.new(repository, 'name'), name
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

    def open_command name
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
      cards = @repository.cards
      formatter = TextReportFormatter.new @io
      a = 0
      @columns.each do |column|
        formatter.add_column(column, @repository.max_field_length(column))
      end
      formatter.output cards
    end
    
    def unfilter_command ignored
      @filter = nil
    end
    
    def columns_command text
      if text
        @columns = text.scan(/\w+/) 
      else
        @io.say "current columns: #{@columns.join(',')}"
        columns = Set.new
        sorted_selection.each do |card|
          columns += card.keys
        end
        @io.say "available columns: #{columns.sort.join(',')}"
      end
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
        @io.say "unclaiming \"#{card['name']}\""
        card.delete('owner')
        @repository.save card
      end
    end

    def set_command text
      key, *rest = text.scan(/\w+/)
      value = @io.ask("Enter the new value for #{key}")
      each_card_from_indices(rest.join(' ')) do |card|
        if value.empty?
          @io.say "removing #{key} from '#{card['name']}'"
          card.delete key
        else
          @io.say "setting #{key} to '#{value}' for '#{card['name']}'"
          card[key] = value
        end
        @repository.save card
      end
    end
  end
end