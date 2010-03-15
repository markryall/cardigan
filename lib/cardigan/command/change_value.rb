require 'cardigan/card_editor'

module Cardigan
  module Command
    class ChangeValue
      def initialize entry, io
        @entry, @io = entry, io
      end

      def execute key
        Cardigan::CardEditor.new(@entry, @io).set key, @io.ask("Enter the new value for #{key}")
      end
    end
  end
end