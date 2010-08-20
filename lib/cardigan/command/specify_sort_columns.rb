require 'cardigan/command/list_cards'

class Cardigan::Command::SpecifySortColumns < Cardigan::Command::ListCards
  def initialize repository, io
    super
    @usage = '<column>*'
    @help = 'Specify the list of columns to sort by'
  end

  def execute text
    if text
      @repository.sort_columns = text.scan(/\w+/)
      super
    else
      @io.say "current columns: #{@repository.sort_columns.join(',')}"
      @io.say "available columns: #{@repository.columns.sort.join(',')}"
    end
  end
end