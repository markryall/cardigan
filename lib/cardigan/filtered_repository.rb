require 'forwardable'
require 'set'

module Cardigan
  class FilteredRepository
    include Enumerable

    attr_accessor :filter, :sort_columns, :display_columns

    extend Forwardable
    def_delegators :@repository, :[], :[]=, :exist?, :destroy, :addremovecommit

    def initialize repository, user, *columns
      @repository, @sort_columns, @display_columns, @user = repository, columns, columns, user
    end

    def cards
      me = @user
      cards = @filter ? @repository.select {|card| eval @filter } : @repository.to_a
      cards.sort do |a,b|
        a_values = sort_columns.map {|col| a[col] ? a[col] : '' }
        b_values = sort_columns.map {|col| b[col] ? b[col] : '' }
        a_values <=> b_values
      end
    end

    def columns
      columns = Set.new
      @repository.each {|card| columns += card.keys }
      columns.to_a
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