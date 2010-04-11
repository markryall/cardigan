class Cardigan::Command::ClaimCards
  def initialize repository, io, name
    @repository, @io, @name = repository, io, name
  end

  def execute numbers
    @repository.each_card_from_indices(numbers) do |card|
      @io.say "claiming \"#{card['name']}\""
      card['owner'] = @name
      @repository.save card
    end
  end
  
  def usage
    '<number> [<number]*'
  end
  
  def help
    'Sets you as the owner of the specified cards'
  end
end