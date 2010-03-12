require 'cardigan/context'

module Cardigan
  class EntryContext
    include Context
    
    def initialize io, entry
      @io, @entry = io, entry
      @prompt_text = "#{File.expand_path('.').split('/').last.slice(0..0)}/#{entry['name']} > "
      @commands = ['set', 'show']
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