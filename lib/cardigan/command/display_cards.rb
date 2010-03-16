module Cardigan::Command::DisplayCards
  def display_cards
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