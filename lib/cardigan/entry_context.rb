require 'cardigan/context'

module Cardigan
  class EntryContext
    include Context

    def initialize io, workflow_repository, entry
      @io, @workflow_repository, @entry = io, workflow_repository, entry
      @prompt_text = "#{File.expand_path('.').split('/').last.slice(0..0)}/#{entry['name']} > "
      @commands = {}
    end

    def refresh_commands
      commands = ['set', 'show']
      status = @entry['status'] || 'none'
      @workflow_repository.load[status].each do |s|
        commands << "now #{s}"
      end
      commands
    end

    def now_command status
      @entry['status'] = status
    end

    def set_command key
      @entry[key] = @io.ask("Enter the new value for #{key}")
    end

    def show_command ignored=nil
      @entry.keys.sort.each do |key|
        @io.say "#{key}: #{@entry[key]}"
      end
    end
  end
end