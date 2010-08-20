require 'cardigan/commands'

class Cardigan::Command::DestroyCards
  attr_reader :usage, :help

  def initialize repository, io
    @repository, @io = repository, io
    @usage = '<number>*'
    @help = 'Destroys the specified cards (by index in the list)'
  end

  def execute numbers
    @repository.each_card_from_indices(numbers) do |card|
      @io.say "destroying \"#{card['name']}\""
      @repository.destroy card.id
    end
  end
end
