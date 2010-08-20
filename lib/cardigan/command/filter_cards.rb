require 'cardigan/command/list_cards'

class Cardigan::Command::FilterCards < Cardigan::Command::ListCards
  def initialize repository, io
    super
    @usage = '<ruby expression>'
    @help = "Sets the filter on cards to be displayed\nThis filter is a ruby expression that must return a boolean.\nBound variables are card (a hash) and me (a string)"
  end

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