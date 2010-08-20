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
    columns = @repository.columns - ['id']
    CSV.open(filename, 'w') do |writer|
      writer << (['id'] + columns)
      @repository.cards.each do |card|
        writer << ([card.id] + columns.map {|column| card[column] ? card[column] : ''})
      end
    end
  end
end