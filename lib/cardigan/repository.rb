require 'cardigan/directory'

module Cardigan
  class Repository
    attr_reader :cards

    def initialize path
      @directory = Directory.new(path)
      @directory.create
    end

    def refresh
      @cards = @directory.find('*.card')
    end

    def find_card name
      @cards.find {|card| card['name'] == name}
    end

    def save card
      @directory.store "#{card['id']}.card", card
    end

    def destroy card
      @directory.delete "#{card['id']}.card"
    end

    def find_or_create name
      card = find_card(name)
      card or { 'id' => UUIDTools::UUID.random_create.to_s,
        'name' => name
      }
    end

    def max_field_length name
      cards.map {|card| card[name] ? card[name].length : 0 }.max
    end

    def each_card_from_indices numbers
      cards = sorted_selection
      numbers.scan(/\d+/).each do |n|
        yield cards[n.to_i - 1]
      end
    end
  end
end