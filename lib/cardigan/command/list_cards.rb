require 'cardigan/commands'
require 'cardigan/text_report_formatter'

class Cardigan::Command::ListCards
  attr_reader :usage, :help

  def initialize repository, io
    @repository, @io = repository, io
    @usage = ''
    @help = 'Lists all cards that match the current filter'
  end

  def execute text
    cards = @repository.cards
    if cards.empty?
      @io.say "There are no cards to display"
      return
    end
    formatter = Cardigan::TextReportFormatter.new @io
    @repository.display_columns.each do |column|
      formatter.add_column(column, @repository.max_field_length(column))
    end
    formatter.output cards
  end
end