require 'readline'

module Cardigan
  module Context
    def refresh
      refresh_commands if respond_to?(:refresh_commands)
      Readline.completion_proc = lambda do |text|
        (@commands + ['quit', 'exit']).grep( /^#{Regexp.escape(text)}/ ).sort
      end
      Readline.completer_word_break_characters = ''
    end
    
    def push
      refresh
      begin
        while line = Readline.readline(@prompt_text, true)
          line.strip!
          case line
            when 'quit','exit'
              return
            when /(\w+) (.*)/
              m = "#{$1}_command".to_sym
              send(m, $2) if respond_to?(m)
          end
          puts
        end
      rescue Interrupt => e
        return
      end
      puts
    end
  end
end