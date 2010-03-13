require 'rubygems'
require 'uuidtools'
require 'set'
require 'cardigan/context'
require 'cardigan/filtered_repository'
require 'cardigan/command/create_card'
require 'cardigan/command/destroy_cards'
require 'cardigan/command/list_cards'
require 'cardigan/command/open_card'

module Cardigan
  class RootContext
    include Context

    def initialize io, repository, name
      @io, @repository, @name = io, FilteredRepository.new(repository, 'name'), name
      @prompt_text = "#{File.expand_path('.').split('/').last} > "
      @columns = ['name']
      @commands = {
        'create' => Command::CreateCard.new(@repository),
        'destroy' => Command::DestroyCards.new(@repository, @io),
        'list' => Command::ListCards.new(@repository, @io, @columns),
        'open' => Command::OpenCard.new(@repository)
      }
    end

    def refresh_commands
      @repository.refresh
      commands = ['filter', 'unfilter', 'columns', 'claim', 'unclaim']
      commands += @repository.cards.map {|card| "open #{card['name']}" }
      commands
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