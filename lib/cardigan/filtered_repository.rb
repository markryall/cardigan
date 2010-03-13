require 'forwardable'

module Cardigan
  class FilteredRepository
    attr_accessor :filter, :sort

    extend Forwardable

    def_delegators :@repository, :refresh, :max_field_length, :save, :destroy, :find_or_create

    def initialize repository, sort
      @repository, @sort = repository, sort
    end

    def cards
      cards = @filter ? @repository.cards.select {|card| eval @filter } : @repository.cards
      cards.sort {|a,b| a[sort] <=> b[sort] }
    end
  end
end