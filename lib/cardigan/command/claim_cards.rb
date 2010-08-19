require 'cardigan/commands'

class Cardigan::Command::ClaimCards
  attr_reader :usage, :help

  def initialize repository, io, name
    @repository, @io, @name = repository, io, name
    @usage = '<number> [<number]*'
    @help = 'Sets you as the owner of the specified cards'
  end

  def execute numbers
    @repository.each_card_from_indices(numbers || '') do |card|
      @io.say "claiming \"#{card['name']}\""
      card['owner'] = @name
      @repository.save card
    end
  end
end