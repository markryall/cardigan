require 'cardigan/context'

module Cardigan
  class EntryContext
    include Context

    def initialize io, workflow_repository, entry
      @io, @workflow_repository, @entry = io, workflow_repository, entry
      @prompt_text = "#{File.expand_path('.').split('/').last.slice(0..0)}/#{entry['name']} > "
      @commands = {
        'now' => command(:change_status, @entry),
        'set' => command(:change_value, @entry, @io),
        'list' => command(:show_entry, @entry, @io)
      }
    end

    def refresh_commands
      status = @entry['status'] || 'none'
      next_statuses = @workflow_repository.load[status]
      next_statuses ? next_statuses.map { |s| "now #{s}" } : []
    end
  end
end