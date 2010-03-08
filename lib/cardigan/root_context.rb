require 'readline'

module Cardigan
  class RootContext
    def initialize *args
      @prompt_text = 'cardigan > '
    end

    def push
      begin
        while line = Readline.readline(@prompt_text, true)
          line.strip!
          case line
            when 'quit'
              return
          end
          puts
        end
      rescue Interrupt => e
        exit
      end
      puts
    end
  end
end
    