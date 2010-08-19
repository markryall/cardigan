require 'rubygems'
require 'shell_shock/context'
require 'cardigan/commands'
require 'cardigan/filtered_repository'

module Cardigan
  class RootContext
    include ShellShock::Context

    def initialize io, repository, name, workflow_repository
      @io, @repository, @name, @workflow_repository = io, FilteredRepository.new(repository, name, 'name'), name, workflow_repository
      @prompt_text = "#{File.expand_path('.').split('/').last} > "
      @commands = {
        'claim'    => Command.load(:claim_cards, @repository, @io, @name),
        'touch'    => Command.load(:create_card, @repository),
        'rm'       => Command.load(:destroy_cards, @repository, @io),
        'columns'  => Command.load(:specify_display_columns, @repository, @io),
        'filter'   => Command.load(:filter_cards, @repository, @io),
        'ls'       => Command.load(:list_cards, @repository, @io),
        'cd'       => Command.load(:open_card, @repository, @workflow_repository, @io),
        'set'      => Command.load(:batch_update_cards, @repository, @io),
        'sort'     => Command.load(:specify_sort_columns, @repository, @io),
        'unclaim'  => Command.load(:unclaim_cards, @repository, @io),
        'unfilter' => Command.load(:unfilter_cards, @repository, @io),
        'workflow' => Command.load(:open_workflow, @workflow_repository, @io),
        'count'    => Command.load(:count_cards, @repository, @io),
        'total'    => Command.load(:total_cards, @repository, @io),
        'export'   => Command.load(:export_cards, @repository),
        'import'   => Command.load(:import_cards, @repository, @io)
      }
    end
  end
end