require 'cardigan/text_report_formatter'

class Cardigan::Command::ListCards
  def initialize repository, io
    @repository, @io = repository, io
  end

  def execute text
    cards = @repository.cards
    formatter = Cardigan::TextReportFormatter.new @io
    @repository.display_columns.each do |column|
      formatter.add_column(column, @repository.max_field_length(column))
    end
    formatter.output cards
  end
end