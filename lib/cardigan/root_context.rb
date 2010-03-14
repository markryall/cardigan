require 'rubygems'
require 'uuidtools'
require 'set'
require 'cardigan/context'
require 'cardigan/filtered_repository'
require 'cardigan/command/batch_update_cards'
require 'cardigan/command/claim_cards'
require 'cardigan/command/create_card'
require 'cardigan/command/destroy_cards'
require 'cardigan/command/filter_cards'
require 'cardigan/command/list_cards'
require 'cardigan/command/open_card'
require 'cardigan/command/open_workflow'
require 'cardigan/command/specify_display_columns'
require 'cardigan/command/specify_sort_columns'
require 'cardigan/command/unclaim_cards'
require 'cardigan/command/unfilter_cards'

module Cardigan
  class RootContext
    include Context

    def initialize io, repository, name, workflow_repository
      @io, @repository, @name, @workflow_repository = io, FilteredRepository.new(repository, 'name'), name, workflow_repository
      @prompt_text = "#{File.expand_path('.').split('/').last} > "
      @commands = {
        'claim' => Command::ClaimCards.new(@repository, @io),
        'create' => Command::CreateCard.new(@repository),
        'destroy' => Command::DestroyCards.new(@repository, @io),
        'display' => Command::SpecifyDisplayColumns.new(@repository, @io),
        'filter' => Command::FilterCards.new(@repository, @io),
        'list' => Command::ListCards.new(@repository, @io),
        'open' => Command::OpenCard.new(@repository, @workflow_repository, @io),
        'set' => Command::BatchUpdateCards.new(@repository, @io),
        'sort' => Command::SpecifySortColumns.new(@repository, @io),
        'unclaim' => Command::UnclaimCards.new(@repository, @io),
        'unfilter' => Command::UnfilterCards.new(@repository),
        'workflow' => Command::OpenWorkflow.new(@workflow_repository, @io)
      }
    end

    def refresh_commands
      @repository.refresh
      @repository.cards.map {|card| "open #{card['name']}" }
    end
  end
end