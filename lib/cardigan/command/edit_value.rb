require 'splat'
require 'cardigan/card_editor'

module Cardigan
  module Command
    class EditValue
      def initialize entry, io
        @entry, @io = entry, io
      end

      def execute key
        value = @entry[key] ? @entry[key] : ''
        Cardigan::CardEditor.new(@entry, @io).set key, value.to_editor
      end
    end
  end
end