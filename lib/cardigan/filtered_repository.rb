require 'forwardable'

module Cardigan
  class FilteredRepository
    attr_accessor :filter, :sort_columns, :display_columns

    extend Forwardable

    def_delegators :@repository, :refresh, :save, :destroy, :find_or_create

    def initialize repository, *columns
      @repository, @sort_columns, @display_columns = repository, columns, columns
    end

    def cards
      cards = @filter ? @repository.cards.select {|card| eval @filter } : @repository.cards
      cards.sort do |a,b|
        a_values = sort_columns.map {|col| a[col] ? a[col] : '' }
        b_values = sort_columns.map {|col| b[col] ? b[col] : '' }
        a_values <=> b_values
      end
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