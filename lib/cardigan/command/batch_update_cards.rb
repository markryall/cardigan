require 'cardigan/commands'
require 'cardigan/card_editor'

class Cardigan::Command::BatchUpdateCards
  attr_reader :usage, :help

  def initialize repository, io
    @repository, @io = repository, io
    @usage = '<field> <number>*'
    @help = 'Sets the specified field to a new value for the specified cards (by index in the list)'
  end

  def execute text
    key, *rest = text.scan(/\w+/)
    value = @io.ask("Enter the new value for #{key}")
    @repository.each_card_from_indices(rest.join(' ')) do |card|
      Cardigan::CardEditor.new(card, @io).set key, value
      @repository[card.id] = card
    end
  end
end