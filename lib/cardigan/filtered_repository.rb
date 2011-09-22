require 'forwardable'
require 'set'

module Cardigan
  class FilteredRepository
    include Enumerable

    attr_reader :filter, :sort_columns, :display_columns

    extend Forwardable
    def_delegators :@repository, :[], :[]=, :exist?, :destroy, :addremovecommit

    def initialize repository, user, configuration
      @repository, @user, @configuration = repository, user, configuration
      @sort_columns = multi('sort') || ['name']
      @display_columns = multi('display') || ['name']
      @filter = @configuration['filter']
    end

    def multi key
      return nil unless @configuration[key]
      @configuration[key].split "\n"
    end

    def filter= filter
      @filter = filter
      @configuration['filter'] = filter
    end

    def sort_columns= columns
      @sort_columns = columns
      @configuration['sort'] = columns.join "\n"
    end

    def display_columns= columns
      @display_columns = columns
      @configuration['display'] = columns.join "\n"
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