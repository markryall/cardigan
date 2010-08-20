require 'cardigan/commands'
require 'csv'

class Cardigan::Command::ExportCards
  attr_reader :usage, :help

  def initialize repository
    @repository = repository
    @usage = '<filename>'
    @help = 'Exports all cards according to the current filter'
  end

  def execute filename
    filename += ".csv"
    columns = @repository.columns
    CSV.open(filename, 'w') do |writer|
      writer << columns
      @repository.cards.each do |card|
        writer << columns.map {|column| card[column] ? card[column] : ''}
      end
    end
  end
end