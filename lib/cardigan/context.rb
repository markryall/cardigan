require 'readline'

module Cardigan
  module Context
    def refresh
      commands = respond_to?(:refresh_commands) ? refresh_commands : []
      Readline.completion_proc = lambda do |text|
        (commands + @commands.keys + ['quit', 'exit']).grep( /^#{Regexp.escape(text)}/ ).sort
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
              process_command $1, $2
            when /(\w+)/
              process_command $1
            else
              puts 'unknown command'
          end
          puts
          refresh
        end
      rescue Interrupt => e
        return
      end
      puts
    end

    def process_command name, parameter=nil
      m = "#{name}_command".to_sym
      if respond_to?(m)
        send(m, parameter)
        return
      end 
      if @commands[name]
        @commands[name].execute parameter
      else
        @io.say 'unknown command'
      end
    end
  end
end