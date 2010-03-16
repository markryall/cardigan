require 'cardigan/command/list_cards'

class Cardigan::Command::UnfilterCards < Cardigan::Command::ListCards
  def execute filter
    @repository.filter = nil
    super
  end
end