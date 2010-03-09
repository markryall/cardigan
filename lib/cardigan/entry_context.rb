require 'cardigan/context'

module Cardigan
  class EntryContext
    include Context
    
    def initialize io, entry
      @io, @entry = io, entry
      @prompt_text = "c/#{entry[:name]} > "
      @commands = ['set']
    end
    
    def set_command text
      @entry[:text] = @io.ask('Enter the new value')
    end
  end
end