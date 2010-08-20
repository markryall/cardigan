require 'shell_shock/context'
require 'cardigan/commands'

class Cardigan::WorkflowContext
  include ShellShock::Context

  def initialize io, entry
    @io, @entry = io, entry
    @prompt_text = "#{File.expand_path('.').split('/').last.slice(0..0)}/workflow > "
    @commands = {
      'ls'     => Cardigan::Command.load(:show_entry, @entry, @io),
      'add'    => Cardigan::Command.load(:add_transitions, @entry, @io),
      'rm'     => Cardigan::Command.load(:remove_transitions, @entry),
    }
  end
end