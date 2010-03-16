require 'rubygems'
require 'uuidtools'
require 'set'
require 'cardigan/context'
require 'cardigan/filtered_repository'

module Cardigan
  class RootContext
    include Context

    def initialize io, repository, name, workflow_repository
      @io, @repository, @name, @workflow_repository = io, FilteredRepository.new(repository, name, 'name'), name, workflow_repository
      @prompt_text = "#{File.expand_path('.').split('/').last} > "
      @commands = {
        'claim' => command(:claim_cards, @repository, @io, @name),
        'create' => command(:create_card, @repository),
        'destroy' => command(:destroy_cards, @repository, @io),
        'display' => command(:specify_display_columns, @repository, @io),
        'filter' => command(:filter_cards, @repository, @io),
        'list' => command(:list_cards, @repository, @io),
        'open' => command(:open_card, @repository, @workflow_repository, @io),
        'set' => command(:batch_update_cards, @repository, @io),
        'sort' => command(:specify_sort_columns, @repository, @io),
        'unclaim' => command(:unclaim_cards, @repository, @io),
        'unfilter' => command(:unfilter_cards, @repository),
        'workflow' => command(:open_workflow, @workflow_repository, @io),
        'count' => command(:count_cards, @repository, @io),
        'total' => command(:total_cards, @repository, @io),
        'export' => command(:export_cards, @repository),
        'import' => command(:import_cards, @repository)
      }
    end

    def refresh_commands
      @repository.refresh
      @repository.cards.map {|card| "open #{card['name']}" }
    end
  end
end