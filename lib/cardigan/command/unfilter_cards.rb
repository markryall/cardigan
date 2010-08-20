require 'cardigan/command/list_cards'

class Cardigan::Command::UnfilterCards < Cardigan::Command::ListCards
  def initialize repository, io
    super
    @usage = ''
    @help = 'Removes the current filter (or does nothing if no filter has been specified)'
  end

  def execute filter
    @repository.filter = nil
    super
  end
end