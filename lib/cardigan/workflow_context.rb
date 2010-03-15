require 'cardigan/context'

module Cardigan
  class WorkflowContext
    include Context

    def initialize io, entry
      @io, @entry = io, entry
      @prompt_text = "#{File.expand_path('.').split('/').last.slice(0..0)}/workflow > "
      @commands = {
        'list' => command(:show_entry, @entry, @io)
      }
    end

    def refresh_commands
      ['create', 'add', 'remove']
    end

    def create_command key
      @entry[key] = []
    end

    def add_command text
      name, *states = text.scan(/\w+/)
      @entry[name] += states
    end

    def remove_command text
      name, *states = text.scan(/\w+/)
      @entry[name] -= states
    end
  end
end