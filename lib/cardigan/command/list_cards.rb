require 'cardigan/text_report_formatter'
require 'cardigan/command/display_cards'

class Cardigan::Command::ListCards
  include Cardigan::Command::DisplayCards

  def initialize repository, io
    @repository, @io = repository, io
  end

  def execute text
    display_cards
  end
end