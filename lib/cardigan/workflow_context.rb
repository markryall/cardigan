require 'shell_shock/context'
require 'cardigan/commands'

module Cardigan
  class WorkflowContext
    include ShellShock::Context

    def initialize io, entry
      @io, @entry = io, entry
      @prompt_text = "#{File.expand_path('.').split('/').last.slice(0..0)}/workflow > "
      @commands = {
        'list'               => Command.load(:show_entry, @entry, @io),
        'create_status'      => Command.load(:create_status, @entry),
        'add_transitions'    => Command.load(:add_transitions, @entry),
        'remove_transitions' => Command.load(:remove_transitions, @entry),
      }
    end
  end
end