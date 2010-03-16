require 'cardigan/command/display_cards'

class Cardigan::Command::SpecifySortColumns
  include Cardigan::Command::DisplayCards

  def initialize repository, io
    @repository, @io = repository, io
  end

  def execute text
    if text
      @repository.sort_columns = text.scan(/\w+/)
      display_cards
    else
      @io.say "current columns: #{@repository.sort_columns.join(',')}"
      @io.say "available columns: #{@repository.columns.sort.join(',')}"
    end
  end
end