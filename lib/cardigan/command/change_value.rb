require 'cardigan/commands'
require 'cardigan/card_editor'

class Cardigan::Command::ChangeValue
  attr_reader :usage, :help

  def initialize entry, io
    @entry, @io = entry, io
    @usage = '<key>'
    @help = 'Prompt for a new value to associate with the specified key'
  end

  def execute key
    Cardigan::CardEditor.new(@entry, @io).set key, @io.ask("Enter the new value for #{key}")
  end
end