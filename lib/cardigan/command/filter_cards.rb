require 'cardigan/command/list_cards'

class Cardigan::Command::FilterCards < Cardigan::Command::ListCards
  def execute filter
    @repository.filter = filter
    begin
      super
    rescue Exception => e
      @io.say "Invalid expression:\n#{e.message}"
      @repository.filter = nil
    end
  end
end