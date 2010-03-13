require 'forwardable'

module Cardigan
  class FilteredRepository
    attr_accessor :filter, :sort

    extend Forwardable

    def_delegators :@repository, :refresh, :save, :destroy, :find_or_create

    def initialize repository, sort
      @repository, @sort = repository, sort
    end

    def cards
      cards = @filter ? @repository.cards.select {|card| eval @filter } : @repository.cards
      cards.sort {|a,b| a[sort] <=> b[sort] }
    end

    def max_field_length name
      cards.map {|card| card[name] ? card[name].length : 0 }.max
    end

    def each_card_from_indices numbers
      c = cards
      numbers.scan(/\d+/).each do |n|
        yield c[n.to_i - 1]
      end
    end
  end
end