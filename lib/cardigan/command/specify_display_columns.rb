require 'cardigan/command/list_cards'

class Cardigan::Command::SpecifyDisplayColumns < Cardigan::Command::ListCards
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