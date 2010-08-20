require 'cardigan/command/list_cards'

class Cardigan::Command::SpecifyDisplayColumns < Cardigan::Command::ListCards
  def initialize repository, io
    super
    @usage = '<column>*'
    @help = 'Specify the list of columns to display'
  end

  def execute text
    if text
      @repository.display_columns = text.scan(/\w+/)
      super
    else
      @io.say "current columns: #{@repository.display_columns.join(',')}"
      @io.say "available columns: #{@repository.columns.sort.join(',')}"
    end
  end
end