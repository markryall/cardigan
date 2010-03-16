require 'rubygems'
require 'uuidtools'
require 'set'
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
      find_card(name) or create('name' => name)
    end

    def each
      @cards.each {|card| yield card}
    end

    def columns
      columns = Set.new
      each {|card| columns += card.keys }
      columns.to_a
    end

    def load id
      file = "#{id}.card"
      @directory.has_file?(file) ? @directory.load(file) : nil
    end
    
    def create hash={}
      { 'id' => UUIDTools::UUID.random_create.to_s }.merge hash
    end
  end
end