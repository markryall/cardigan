require 'cardigan/commands'

class Cardigan::Command::ClaimCards
  attr_reader :usage, :help

  def initialize repository, io, name
    @repository, @io, @name = repository, io, name
    @usage = '<number>*'
    @help = 'Sets you as the owner of the specified cards (by index in the list)'
  end

  def execute numbers
    @repository.each_card_from_indices(numbers || '') do |card|
      @io.say "claiming \"#{card['name']}\""
      card['owner'] = @name
      @repository[card.id] = card
    end
  end
end