require 'rubygems'
require 'uuidtools'
require 'set'
require 'cardigan/context'
require 'cardigan/filtered_repository'
require 'cardigan/command/claim_cards'
require 'cardigan/command/create_card'
require 'cardigan/command/destroy_cards'
require 'cardigan/command/filter_cards'
require 'cardigan/command/list_cards'
require 'cardigan/command/open_card'
require 'cardigan/command/select_columns'
require 'cardigan/command/unclaim_cards'
require 'cardigan/command/unfilter_cards'

module Cardigan
  class RootContext
    include Context

    def initialize io, repository, name
      @io, @repository, @name = io, FilteredRepository.new(repository, 'name', 'name'), name
      @prompt_text = "#{File.expand_path('.').split('/').last} > "
      @commands = {
        'claim' => Command::ClaimCards.new(@repository, @io),
        'columns' => Command::SelectColumns.new(@repository, @io),
        'create' => Command::CreateCard.new(@repository),
        'destroy' => Command::DestroyCards.new(@repository, @io),
        'filter' => Command::FilterCards.new(@repository, @io),
        'list' => Command::ListCards.new(@repository, @io),
        'open' => Command::OpenCard.new(@repository),
        'unclaim' => Command::UnclaimCards.new(@repository, @io),
        'unfilter' => Command::UnfilterCards.new(@repository)
      }
    end

    def refresh_commands
      @repository.refresh
      @repository.cards.map {|card| "open #{card['name']}" }
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