require 'shell_shock/context'
require 'cardigan/commands'

module Cardigan
  class EntryContext
    include ShellShock::Context

    def initialize io, workflow_repository, entry
      @io, @workflow_repository, @entry = io, workflow_repository, entry
      @prompt_text = "#{File.expand_path('.').split('/').last.slice(0..0)}/#{entry['name']} > "
      @commands = {
        'now'  => Command.load(:change_status, @entry, @workflow_repository),
        'set'  => Command.load(:change_value, @entry, @io),
        'edit' => Command.load(:edit_value, @entry, @io),
        'list' => Command.load(:show_entry, @entry, @io)
      }
    end
  end
end