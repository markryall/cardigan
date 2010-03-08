require 'cardigan/context'

module Cardigan
  class RootContext
    include Context

    def initialize *args
      @prompt_text = 'cardigan > '
      @commands = ['add']
    end
private
    def add_command
      "here's where i'd be adding"
    end
  end
end
    