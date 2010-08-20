require 'shell_shock/context'
require 'cardigan/commands'

class Cardigan::WorkflowContext
  include ShellShock::Context

  def initialize io, entry
    @io, @entry = io, entry
    @prompt_text = "#{File.expand_path('.').split('/').last.slice(0..0)}/workflow > "
    @commands = {
      'list'               => Cardigan::Command.load(:show_entry, @entry, @io),
      'create_status'      => Cardigan::Command.load(:create_status, @entry),
      'add_transitions'    => Cardigan::Command.load(:add_transitions, @entry, @io),
      'remove_transitions' => Cardigan::Command.load(:remove_transitions, @entry),
    }
  end
end