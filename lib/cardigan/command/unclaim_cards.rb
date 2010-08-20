class Cardigan::Command::UnclaimCards
  attr_reader :usage, :help

  def initialize repository, io
    @repository, @io = repository, io
    @usage = '<number> [<number]*'
    @help = 'Removes the owner of the specified cards'
  end

  def execute numbers
    @repository.each_card_from_indices(numbers || '') do |card|
      @io.say "unclaiming \"#{card['name']}\""
      card.delete('owner')
      @repository[card.id] = card
    end
  end
end