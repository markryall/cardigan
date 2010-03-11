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
  end
end