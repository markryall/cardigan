module Cardigan
  module Command
    class ShowEntry
      def initialize entry, io
        @entry, @io = entry, io
      end

      def execute ignored=nil
        @entry.keys.sort.each { |key| @io.say "#{key}: #{@entry[key].inspect}" }
      end
    end
  end
end