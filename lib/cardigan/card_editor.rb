module Cardigan
  class CardEditor
    def initialize card, io
      @card, @io = card, io
    end

    def set key, value
      if value.empty?
        @io.say "removing #{key} from '#{@card['name']}'"
        @card.delete key
      else
        @io.say "setting #{key} to '#{value}' for '#{@card['name']}'"
        @card[key] = value
      end
    end
  end
end