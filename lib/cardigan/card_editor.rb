module Cardigan
  class CardEditor
    def initialize card, io
      @card, @io = card, io
    end

    def set key, value
      return if key == 'id'
      value = '' unless value
      if value.empty?
        if @card[key]
          @io.say "removing #{key} from '#{@card['id']}'"
          @card.delete key
        end
      else
        unless @card[key] == value
          @io.say "changing #{key} from '#{@card[key]}' to '#{value}' for '#{@card['id']}'"
          @card[key] = value
        end
      end
    end
  end
end